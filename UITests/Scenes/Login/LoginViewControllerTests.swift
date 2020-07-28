//
//  LoginViewControllerTests.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation
@testable import UI

class LoginViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }

    func test_sut_conforms_loading_view_protocol() {
        XCTAssertNotNil(makeSut() as LoadingViewProtocol)
    }

    func test_sut_conforms_alert_view_protocol() {
        XCTAssertNotNil(makeSut() as AlertViewProtocol)
    }

    func test_sut_loginButton_calls_login_on_tap() {
        var loginRequest: LoginRequest?
        let sut = makeSut(loginSpy: { loginRequest = $0 })
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text

        sut.loginButton?.simulateTap()
        
        XCTAssertEqual(loginRequest, LoginRequest(email: email, password: password))
    }
}
