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
