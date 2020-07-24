//
//  Authentication.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 24/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public struct Authentication: Model {
    public var email: String
    public var password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
