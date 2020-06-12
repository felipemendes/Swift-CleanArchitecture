//
//  RemoteAddAccountTests+Extensions.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 09/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation

extension RemoteAddAccountTests {

    // MARK: - Factory

    func makeSut(url: URL = URL(string: "http://url.com")!,
                 file: StaticString = #file,
                 line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let url = url
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)

        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)

        return (sut, httpClientSpy)
    }

    func makeUrl() -> URL {
        return URL(string: "http://url.com")!
    }

    func makeInvalidData() -> Data {
        return Data("invalid_json".utf8)
    }

    func makeAccountRequest() -> AccountRequest {
        return AccountRequest(name: "Felipe",
                              email: "felipe@email.com",
                              password: "123456",
                              passwordConfirmation: "123456")
    }

    func makeAccountResponse() -> AccountResponse {
        return AccountResponse(identifier: "123",
                               name: "Felipe",
                               email: "felipe@email.com")
    }
}
