//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Domain
import Data

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
                XCTAssertEqual(error, .message("Error: Unexpected"))
            case .success:
                XCTFail("Error: Expected error but received \(result) instead")
            }
            exp.fulfill()
        }
        
        httpClientSpy.completeWith(error: .message("Error: No connectivity"))
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
                XCTAssertEqual(error, .message("Error: Invalid data"))
            case .success:
                XCTFail("Error: Expected error but received \(result) instead")
            }
            exp.fulfill()
        }

        httpClientSpy.completeWith(data: makeInvalidData())
        wait(for: [exp], timeout: 1)
    }
}

extension RemoteAddAccountTests {
    
    // MARK: - Factory

    func makeSut(url: URL = URL(string: "http://url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let url = url
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }

    func makeUrl() -> URL {
        return URL(string: "http://url.com")!
    }

    func makeInvalidData() -> Data {
        return Data("invalid_json".utf8)
    }

    func makeAccountRequest() -> AccountRequest {
        return AccountRequest(name: "Felipe", email: "felipe@email.com", password: "123456", passwordConfirmation: "123456")
    }

    func makeAccountResponse() -> AccountResponse {
        return AccountResponse(id: "123", name: "Felipe", email: "felipe@email.com")
    }

    // MARK: - HttpClient Test Double

    class HttpClientSpy: HttpPostClientProtocol {
        var url: URL?
        var data: Data?
        var completion: ((Result<Data, MessageError>) -> Void)?

        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, MessageError>) -> Void) {
            self.url = url
            self.data = data
            self.completion = completion
        }

        func completeWith(error: MessageError) {
            completion?(.failure(error))
        }

        func completeWith(data: Data) {
            completion?(.success(data))
        }
    }
}
