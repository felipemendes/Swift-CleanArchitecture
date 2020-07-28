//
//  WelcomeViewControllerTests.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit
import XCTest
@testable import UI

class WelcomeViewControllerTests: XCTestCase {
    func test_loginButton_calls_login_on_tap() {
        let (sut, buttonSpy) = makeSut()
        sut.loginButton?.simulateTap()
        XCTAssertEqual(buttonSpy.clicks, 1)
    }

    func test_signUpButton_calls_signUp_on_tap() {
        let (sut, buttonSpy) = makeSut()
        sut.sigUpButton?.simulateTap()
        XCTAssertEqual(buttonSpy.clicks, 1)
    }
}
