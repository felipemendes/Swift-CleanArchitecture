//
//  RemoteAddAccountTests.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Domain

class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "http://url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(accountRequest: makeAccountRequest())
        
        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_add_should_call_httpClient_with_correct_data() {
        let accountRequest = makeAccountRequest()
        let (sut, httpClientSpy) = makeSut()
        sut.add(accountRequest: accountRequest)

        XCTAssertEqual(httpClientSpy.data, accountRequest.toData())
    }
}

extension RemoteAddAccountTests {
    // Factory

    func makeSut(url: URL = URL(string: "http://url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let url = url
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }

    func makeAccountRequest() -> AccountRequest {
        return AccountRequest(name: "Felipe", email: "felipe@email.com", password: "123456", passwordConfirmation: "123456")
    }

    // HttpClient Test Double

    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?

        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient

    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }

    func add(accountRequest: AccountRequest) {
        httpClient.post(to: url, with: accountRequest.toData())
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
