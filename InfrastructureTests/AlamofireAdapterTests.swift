//
//  AlamofireAdapterTests.swift
//  InfrastructureTests
//
//  Created by Felipe Ribeiro Mendes on 12/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Alamofire
import Data
import Domain
import XCTest
import Infrastructure

class AlamofireAdapterTests: XCTestCase {
    func test_post_should_make_request_with_valid_url_and_method() {
        let url = makeUrl()
        let data = makeValidData()

        testRequestFor(url: url, data: data) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }

    func test_post_should_make_request_without_data() {
        testRequestFor(data: nil) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }

    func test_post_should_completes_with_error_when_request_completes_with_error() {
        expectResult(.failure(.unexpected), when: (data: nil, response: nil, error: makeError()))
    }

    func test_post_should_completes_with_error_on_all_invalid_cases() {
        expectResult(.failure(.unexpected), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.unexpected), when: (data: makeValidData(), response: nil, error: makeError()))
        expectResult(.failure(.unexpected), when: (data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.unexpected), when: (data: nil, response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.unexpected), when: (data: nil, response: makeHttpResponse(), error: nil))
        expectResult(.failure(.unexpected), when: (data: nil, response: nil, error: nil))
    }

    func test_post_should_completes_with_data_when_request_completes_with_200() {
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil))
    }

    func test_post_should_completes_without_data_when_request_completes_with_204() {
        expectResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
    }

    func test_post_should_completes_with_data_when_request_completes_with_non_400() {
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
    }
}

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
