//
//  SignUpRequest.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 26/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation

public struct SignUpRequest: Model {

    // MARK: - PUBLIC PROPERTIES

    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?

    // MARK: - INITIALIZER

    public init(name: String? = nil,
                email: String? = nil,
                password: String? = nil,
                passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }

    // MARK: - PUBLIC API

    public func toAccountRequest() -> AccountRequest? {
        guard let name = name,
            let email = email,
            let password = password,
            let passwordConfirmation = passwordConfirmation else { return nil }

        return AccountRequest(name: name,
                              email: email,
                              password: password,
                              passwordConfirmation: passwordConfirmation)
    }
}
