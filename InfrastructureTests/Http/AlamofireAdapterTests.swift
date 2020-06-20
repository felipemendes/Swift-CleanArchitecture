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

    func test_post_should_completes_with_data_when_request_completes_with_non_200() {
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 300), error: nil))
    }
}
