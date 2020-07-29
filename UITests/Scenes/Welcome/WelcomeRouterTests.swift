//
//  WelcomeRouterTests.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UI
import UIKit
import XCTest

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

    func goToLogin() {
        navigation.pushViewController(loginFactory())
    }

    func goToSignUp() {
        navigation.pushViewController(signUpFactory())
    }
}

class WelcomeRouterTests: XCTestCase {
    func test_goToLogin_calls_nav_with_correct_viewController() {
        let (sut, navigation) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(navigation.viewControllers.count, 1)
        XCTAssertTrue(navigation.viewControllers[0] is LoginViewController)
    }

    func test_goToSignUp_calls_nav_with_correct_viewController() {
        let (sut, navigation) = makeSut()
        sut.goToSignUp()
        XCTAssertEqual(navigation.viewControllers.count, 1)
        XCTAssertTrue(navigation.viewControllers[0] is SignUpViewController)
    }
}

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
