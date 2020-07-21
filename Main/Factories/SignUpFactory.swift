//
//  SignUpFactory.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Foundation
import Infrastructure
import Presentation
import UI
import Validation

class SignUpFactory {
    static func makeSignUpController() -> SignUpViewController {
        let signUpController = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter()
        guard let url = URL(string: "http://localhost:8888/api/signup") else {
            fatalError("Unconstructable SignUp URL")
        }
        let remoteAddAccount = RemoteAddAccount(url: url,
                                                httpClient: alamofireAdapter)
        let presenter = SignUpPresenter(alertView: signUpController,
                                        emailValidator: emailValidatorAdapter,
                                        addAccount: remoteAddAccount,
                                        loadingView: signUpController)

        signUpController.signUp = presenter.signUp
        return signUpController
    }
}
