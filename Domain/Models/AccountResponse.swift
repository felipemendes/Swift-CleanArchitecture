//
//  AccountResponse.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public struct AccountResponse: Model {
    public var id: String
    public var name: String
    public var email: String

    public init(id: String,
                name: String,
                email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}
