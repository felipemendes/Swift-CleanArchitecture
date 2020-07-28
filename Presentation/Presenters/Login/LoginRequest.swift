//
//  LoginRequest.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 27/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation

public struct LoginRequest: Model {

    // MARK: - PUBLIC PROPERTIES

    public var email: String?
    public var password: String?

    // MARK: - INITIALIZER

    public init(email: String? = nil,
                password: String? = nil) {
        self.email = email
        self.password = password
    }

    // MARK: - PUBLIC API

    public func toAuthentication() -> Authentication? {
        guard let email = email,
            let password = password else { return nil }

        return Authentication(email: email,
                              password: password)
    }
}
