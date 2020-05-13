//
//  AccountRequest.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public struct AccountRequest {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String

    public init(name: String,
                email: String,
                password: String,
                passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
