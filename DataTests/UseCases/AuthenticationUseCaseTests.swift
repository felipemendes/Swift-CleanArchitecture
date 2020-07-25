//
//  AuthenticationUseCaseTests.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 24/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import XCTest

class AuthenticationUseCaseTests: XCTestCase {
    func test_auth_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth(authentication: makeAuthentication()) { _ in }

        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_auth_should_call_httpClient_with_correct_data() {
        let authentication = makeAuthentication()
        let (sut, httpClientSpy) = makeSut()
        sut.auth(authentication: authentication) { _ in }

        XCTAssertEqual(httpClientSpy.data, authentication.toData())
    }

    func test_auth_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        let authentication = makeAuthentication()
        let exp = expectation(description: "waiting")

        sut.auth(authentication: authentication) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
            case .success:
                XCTFail("Error: Expected error but received \(result) instead")
            }
            exp.fulfill()
        }

        httpClientSpy.completeWith(error: .unexpected)
        wait(for: [exp], timeout: 1)
    }

    func test_auth_should_complete_with_expired_session_if_client_completes_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        let authentication = makeAuthentication()
        let exp = expectation(description: "waiting")

        sut.auth(authentication: authentication) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .expiredSession)
            case .success:
                XCTFail("Error: Expected error but received \(result) instead")
            }
            exp.fulfill()
        }

        httpClientSpy.completeWith(error: .unauthorized)
        wait(for: [exp], timeout: 1)
    }

    func test_auth_should_complete_with_account_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let authentication = makeAuthentication()
        let expectedAccount = makeAccountResponse()
        let exp = expectation(description: "waiting")

        sut.auth(authentication: authentication) { result in
            switch result {
            case .failure:
                XCTFail("Error: Expected success but received \(result) instead")
            case .success(let receivedAcccount):
                XCTAssertEqual(receivedAcccount, expectedAccount)
            }
            exp.fulfill()
        }

        httpClientSpy.completeWith(data: expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }

    func test_auth_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        let authentication = makeAuthentication()
        let exp = expectation(description: "waiting")

        sut.auth(authentication: authentication) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
            case .success:
                XCTFail("Error: Expected error but received \(result) instead")
            }
            exp.fulfill()
        }

        httpClientSpy.completeWith(data: makeInvalidData())
        wait(for: [exp], timeout: 1)
    }

    func test_auth_should_not_complete_if_sut_has_been_deallocated() {
        let authentication = makeAuthentication()
        let httpClientSpy = HttpClientSpy()
        var sut: AuthenticationUseCase? = AuthenticationUseCase(url: makeUrl(), httpClient: httpClientSpy)
        var result: AuthenticationUseCaseProtocol.ServiceReturnType?

        sut?.auth(authentication: authentication) { result = $0 }
        sut = nil
        httpClientSpy.completeWith(error: .noConnectivity)
        XCTAssertNil(result)
    }
}
