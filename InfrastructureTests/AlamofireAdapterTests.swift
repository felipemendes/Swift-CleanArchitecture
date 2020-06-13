//
//  AlamofireAdapterTests.swift
//  InfrastructureTests
//
//  Created by Felipe Ribeiro Mendes on 12/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireAdapter {

    // MARK: - PRIVATE PROPERTIES

    private let session: Session

    // MARK: - INITIALIZERS

    init(session: Session = .default) {
        self.session = session
    }

    // MARK: - PUBLIC API

    func post(to url: URL, with data: Data?) {
        let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}

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
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?

    static func requestObserver(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }

    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override open func startLoading() {
        UrlProtocolStub.emit?(request)
    }

    override open func stopLoading() { }
}
