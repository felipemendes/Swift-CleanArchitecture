//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import XCTest

class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        let accountRequest = makeAccountRequest()
        sut.add(accountRequest: accountRequest) { _ in }

        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_add_should_call_httpClient_with_correct_data() {
        let accountRequest = makeAccountRequest()
        let (sut, httpClientSpy) = makeSut()
        sut.add(accountRequest: accountRequest) { _ in }

        XCTAssertEqual(httpClientSpy.data, accountRequest.toData())
    }

    func test_add_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        let accountRequest = makeAccountRequest()
        let exp = expectation(description: "waiting")

        sut.add(accountRequest: accountRequest) { result in
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

    func test_add_should_complete_with_account_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let accountRequest = makeAccountRequest()
        let expectedAccount = makeAccountResponse()
        let exp = expectation(description: "waiting")

        sut.add(accountRequest: accountRequest) { result in
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

    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        let accountRequest = makeAccountRequest()
        let exp = expectation(description: "waiting")

        sut.add(accountRequest: accountRequest) { result in
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

    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let accountRequest = makeAccountRequest()
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeUrl(), httpClient: httpClientSpy)
        var result: Result<AccountResponse, MessageError>?

        sut?.add(accountRequest: accountRequest) { result = $0 }
        sut = nil
        httpClientSpy.completeWith(error: .unexpected)
        XCTAssertNil(result)
    }
}
