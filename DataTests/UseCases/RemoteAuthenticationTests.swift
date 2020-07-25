//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 24/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import XCTest

class RemoteAuthenticationTests: XCTestCase {
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
}

extension RemoteAuthenticationTests {

    // MARK: - FACTORY

    func makeSut(url: URL = URL(string: "http://url.com")!,
                 file: StaticString = #file,
                 line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
        let url = url
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)

        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)

        return (sut, httpClientSpy)
    }
}
