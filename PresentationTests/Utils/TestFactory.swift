//
//  TestFactory.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

func makeSignUpRequest(name: String? = "Felipe",
                       email: String? = "felipe@email.com",
                       password: String? = "123456",
                       passwordConfirmation: String? = "123456") -> SignUpRequest {
    return SignUpRequest(name: name,
                         email: email,
                         password: password,
                         passwordConfirmation: passwordConfirmation)
}

func makeLoginRequest(email: String? = "felipe@email.com",
                      password: String? = "123456") -> LoginRequest {
    return LoginRequest(email: email,
                        password: password)
}
