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

/// Builds a AddAccountUseCaseProtocol
///
/// - Returns: An instantiated AddAccountUseCaseProtocol
func makeAddAccount(httpClient: HttpPostClientProtocol) -> AddAccountUseCaseProtocol {
    let addAccountUseCase = AddAccountUseCase(url: makeApiUrl(path: "signup"), httpClient: httpClient)
    return MainQueueDispatchDecorator(addAccountUseCase)
}

/// Builds a AuthenticationUseCaseProtocol
///
/// - Returns: An instantiated AuthenticationUseCaseProtocol
func makeAuthentication(httpClient: HttpPostClientProtocol) -> AuthenticationUseCaseProtocol {
    let authenticationUseCase = AuthenticationUseCase(url: makeApiUrl(path: "login"), httpClient: httpClient)
    return MainQueueDispatchDecorator(authenticationUseCase)
}
