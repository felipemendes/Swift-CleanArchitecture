//
//  AlamofireAdapterTests+Extensions.swift
//  InfrastructureTests
//
//  Created by Felipe Ribeiro Mendes on 13/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Alamofire
import Domain
import Foundation
import XCTest

extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)

        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }

    func testRequestFor(url: URL = makeUrl(), data: Data?, action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        var request: URLRequest?
        let exp = expectation(description: "waiting")

        sut.post(to: url, with: data) { _ in
            exp.fulfill()
        }

        UrlProtocolStub.requestObserver { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }

    func expectResult(_ expectedResult: Result<Data, MessageError>,
                      when stub: (data: Data?, response: HTTPURLResponse?, error: Error?),
                      file: StaticString = #file,
                      line: UInt = #line) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")

        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)

        sut.post(to: makeUrl(), with: nil) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedResult), .success(let receivedResult)):
                XCTAssertEqual(expectedResult, receivedResult, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) but received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }
}
