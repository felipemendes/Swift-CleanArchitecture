//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Felipe Ribeiro Mendes on 12/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccountUseCaseProtocol {
    private let url: URL
    private let httpClient: HttpPostClientProtocol

    public init(url: URL, httpClient: HttpPostClientProtocol  ) {
        self.url = url
        self.httpClient = httpClient
    }

    public func add(accountRequest: AccountRequest, completion: @escaping (Result<AccountResponse, MessageError>) -> Void) {
        httpClient.post(to: url, with: accountRequest.toData()) { result in
            switch result {
            case .success(let data):
                if let model: AccountResponse = data.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.message("Error: Invalid data")))
                }
            case .failure:
                completion(.failure(.message("Error: Unexpected")))
            }
        }
    }
}
