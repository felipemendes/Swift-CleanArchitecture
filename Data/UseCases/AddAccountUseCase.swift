//
//  AddAccountUseCase.swift
//  Data
//
//  Created by Felipe Ribeiro Mendes on 12/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

public final class AddAccountUseCase: AddAccountUseCaseProtocol {

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

    public func add(accountRequest: AccountRequest,
                    completion: @escaping (AddAccountUseCaseProtocol.ServiceReturnType) -> Void) {
        httpClient.post(to: url, with: accountRequest.toData()) { [weak self] result in
            guard self != nil else { return }

            switch result {
            case .success(let data):
                guard let model: AccountResponse = data?.toModel() else {
                    completion(.failure(.unexpected))
                    return
                }
                completion(.success(model))

            case .failure(let error):
                switch error {
                case .forbidden:
                    completion(.failure(.emailInUse))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
