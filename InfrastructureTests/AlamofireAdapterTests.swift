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

class AlamofireAdapter {

    // MARK: - PRIVATE PROPERTIES

    private let session: Session

    // MARK: - INITIALIZERS

    init(session: Session = .default) {
        self.session = session
    }

    // MARK: - PUBLIC API

    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, MessageError>) -> Void) {
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                break
            case .failure:
                completion(.failure(.message("Error: Unexpected")))
            }
        }
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

    func test_post_should_completes_with_error_when_request_completes_with_error() {
        let sut = makeSut()
        let url = makeUrl()
        let exp = expectation(description: "waiting")

        UrlProtocolStub.simulate(data: nil, response: nil, error: makeError())

        sut.post(to: url, with: nil) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, MessageError.message("Error: Unexpected"))
            case .success:
                XCTFail("Expected error but received \(result) instead")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
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
