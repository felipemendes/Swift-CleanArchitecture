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
