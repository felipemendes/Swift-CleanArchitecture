//
//  AuthenticationUseCaseTests+Extensions.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 25/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation

extension AuthenticationUseCaseTests {

    // MARK: - FACTORY

    func makeSut(url: URL = URL(string: "http://url.com")!,
                 file: StaticString = #file,
                 line: UInt = #line) -> (sut: AuthenticationUseCase, httpClientSpy: HttpClientSpy) {
        let url = url
        let httpClientSpy = HttpClientSpy()
        let sut = AuthenticationUseCase(url: url, httpClient: httpClientSpy)

        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)

        return (sut, httpClientSpy)
    }
}
