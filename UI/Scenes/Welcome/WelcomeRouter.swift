//
//  WelcomeRouter.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 29/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public final class WelcomeRouter {

    // MARK: - PRIVATE PROPERTIES

    private let navigation: NavigationController
    private let loginFactory: () -> LoginViewController
    private let signUpFactory: () -> SignUpViewController

    // MARK: - PUBLIC API

    public init(navigation: NavigationController,
                loginFactory: @escaping () -> LoginViewController,
                signUpFactory: @escaping () -> SignUpViewController) {
        self.navigation = navigation
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }

    public func goToLogin() {
        navigation.pushViewController(loginFactory())
    }

    public func goToSignUp() {
        navigation.pushViewController(signUpFactory())
    }
}
