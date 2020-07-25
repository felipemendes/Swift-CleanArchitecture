//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 09/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation

// MARK: - HttpClient Test Double

class HttpClientSpy: HttpPostClientProtocol {
    
    var url: URL?
    var data: Data?
    var completion: ((Result<Data?, MessageError>) -> Void)?

    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, MessageError>) -> Void) {
        self.url = url
        self.data = data
        self.completion = completion
    }

    func completeWith(error: MessageError) {
        completion?(.failure(error))
    }

    func completeWith(data: Data) {
        completion?(.success(data))
    }
}
