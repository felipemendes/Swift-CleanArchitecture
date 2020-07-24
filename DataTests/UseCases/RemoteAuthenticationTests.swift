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
    func test_authentication_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth(authentication: makeAuthentication())

        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_authentication_should_call_httpClient_with_correct_data() {
        let authentication = makeAuthentication()
        let (sut, httpClientSpy) = makeSut()
        sut.auth(authentication: authentication)

        XCTAssertEqual(httpClientSpy.data, authentication.toData())
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
