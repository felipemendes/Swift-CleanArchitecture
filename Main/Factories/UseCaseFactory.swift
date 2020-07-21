//
//  UseCaseFactory.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation
import Infrastructure

final class UseCaseFactory {
    static func makeAddAccount() -> AddAccountUseCaseProtocol {
        let alamofireAdapter = AlamofireAdapter()
        guard let url = URL(string: "http://localhost:8888/api/signup") else {
            fatalError("Unconstructable SignUp URL")
        }
        return RemoteAddAccount(url: url, httpClient: alamofireAdapter)
    }
}
