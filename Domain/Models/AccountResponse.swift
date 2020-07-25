//
//  AccountResponse.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public struct AccountResponse: Model {

    public var accessToken: String

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
