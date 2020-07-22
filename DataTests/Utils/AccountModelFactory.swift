//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 28/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

func makeAccountResponse() -> AccountResponse {
    return AccountResponse(accessToken: "any_token")
}

func makeAccountRequest() -> AccountRequest {
    return AccountRequest(name: "Felipe",
                          email: "felipe@email.com",
                          password: "123456",
                          passwordConfirmation: "123456")
}
