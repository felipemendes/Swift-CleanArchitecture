//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

public final class SignUpMapper {
    static func toAddAccount(signUpViewModel: SignUpViewModel) -> AccountRequest? {
        guard let name = signUpViewModel.name,
            let email = signUpViewModel.email,
            let password = signUpViewModel.password,
            let passwordConfirmation = signUpViewModel.passwordConfirmation else { return nil }

        return AccountRequest(name: name,
                              email: email,
                              password: password,
                              passwordConfirmation: passwordConfirmation)
    }
}
