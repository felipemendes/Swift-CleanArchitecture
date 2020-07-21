//
//  RemoteUseCaseFactory.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation
import Infrastructure

final class RemoteUseCaseFactory {

    // MARK: - PRIVATE PROPERTIES

    private static let httpClient = AlamofireAdapter()
    private static let baseUrl = "http://localhost:8888/api"

    // MARK: - FACTORIES

    /// Builds a AddAccountUseCaseProtocol
    ///
    /// - Returns: An instantiated AddAccountUseCaseProtocol
    static func makeAddAccount() -> AddAccountUseCaseProtocol {
        return RemoteAddAccount(url: makeUrl(path: "signUp"), httpClient: httpClient)
    }
}

extension RemoteUseCaseFactory {

    // MARK: - HELPERS

    private static func makeUrl(path: String) -> URL {
        guard let url = URL(string: "\(baseUrl)/\(path)") else {
            fatalError("Unconstructable \(path) URL")
        }
        return url
    }
}
