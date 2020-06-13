//
//  AlamofireAdapterTests+Extensions.swift
//  InfrastructureTests
//
//  Created by Felipe Ribeiro Mendes on 13/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Alamofire

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

        sut.post(to: url, with: data)

        let exp = expectation(description: "waiting")
        UrlProtocolStub.requestObserver { request in
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
