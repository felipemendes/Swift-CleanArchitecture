//
//  RemoteAuthentication.swift
//  Data
//
//  Created by Felipe Ribeiro Mendes on 24/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAuthentication {

    // MARK: - PRIVATE PROPERTIES

    private let url: URL
    private let httpClient: HttpPostClientProtocol

    // MARK: - INITIALIZERS

    public init(url: URL, httpClient: HttpPostClientProtocol) {
        self.url = url
        self.httpClient = httpClient
    }

    // MARK: - PUBLIC API

    // MARK: Add new account

    public func auth(authentication: Authentication,
                     completion: @escaping (AuthenticationUseCaseProtocol.ServiceReturnType) -> Void) {
        httpClient.post(to: url, with: authentication.toData()) { result in
            switch result {
            case .success:
                break
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
