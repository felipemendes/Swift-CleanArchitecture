//
//  UrlProtocolStub.swift
//  InfrastructureTests
//
//  Created by Felipe Ribeiro Mendes on 20/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

class UrlProtocolStub: URLProtocol {

    // MARK: - PROPERTIES

    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?

    // MARK: - HELPERS

    static func requestObserver(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }

    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }

    // MARK: - URLProtocol Functions

    override open func startLoading() {
        UrlProtocolStub.emit?(request)

        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }

        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override open func stopLoading() { }

    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
}
