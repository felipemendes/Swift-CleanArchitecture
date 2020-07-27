//
//  TestFactory.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "Felipe",
                         email: String? = "felipe@email.com",
                         password: String? = "123456",
                         passwordConfirmation: String? = "123456") -> SignUpViewModel {
    return SignUpViewModel(name: name,
                           email: email,
                           password: password,
                           passwordConfirmation: passwordConfirmation)
}

func makeLoginViewModel(email: String? = "felipe@email.com",
                        password: String? = "123456") -> LoginViewModel {
    return LoginViewModel(email: email,
                          password: password)
}
