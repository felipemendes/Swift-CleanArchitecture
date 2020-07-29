//
//  WelcomeRouterTests+Extensions.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 29/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UI

extension WelcomeRouterTests {
    func makeSut() -> (sut: WelcomeRouter, navigation: NavigationController) {
        let navigation = NavigationController()
        let loginFactorySpy = LoginFactorySpy()
        let signUpFactorySpy = SignUpFactorySpy()
        let sut = WelcomeRouter(navigation: navigation, loginFactory: loginFactorySpy.makeLogin, signUpFactory: signUpFactorySpy.makeSignUp)
        return (sut, navigation)
    }
}

extension WelcomeRouterTests {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }

    class SignUpFactorySpy {
        func makeSignUp() -> SignUpViewController {
            return SignUpViewController.instantiate()
        }
    }
}
