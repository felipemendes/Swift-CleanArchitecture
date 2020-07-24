//
//  AuthenticationUseCaseProtocol.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 24/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public protocol AuthenticationUseCaseProtocol {

    // MARK: - ALIASES

    typealias ServiceReturnType = Result<AccountResponse, MessageError>

    // MARK: - REQUIRED METHODS

    func auth(authentication: Authentication, completion: @escaping (ServiceReturnType) -> Void)
}
