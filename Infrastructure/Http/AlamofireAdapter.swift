//
//  AlamofireAdapter.swift
//  Infrastructure
//
//  Created by Felipe Ribeiro Mendes on 20/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Alamofire
import Data
import Domain
import Foundation

public class AlamofireAdapter: HttpPostClientProtocol {

    // MARK: - PRIVATE PROPERTIES

    private let session: Session

    // MARK: - INITIALIZERS

    public init(session: Session = .default) {
        self.session = session
    }

    // MARK: - PUBLIC API

    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, MessageError>) -> Void) {
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default)
            .responseData { dataResponse in

            guard let statusCode = dataResponse.response?.statusCode else {
                return completion(.failure(.unexpected))
            }

            switch dataResponse.result {
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
