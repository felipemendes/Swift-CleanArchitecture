//
//  SignUpViewControllerTests.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 01/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }

    func test_sut_conforms_loading_view_protocol() {
        XCTAssertNotNil(makeSut() as LoadingViewProtocol)
    }

    func test_sut_conforms_alert_view_protocol() {
        XCTAssertNotNil(makeSut() as AlertViewProtocol)
    }

    func test_sut_saveButton_calls_signUp_on_tap() {
        var signUpRequest: SignUpRequest?
        let sut = makeSut(signUpSpy: { signUpRequest = $0 })
        let name = sut.nameTextField.text
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text
        let passwordConfirmation = sut.passwordConfirmationTextField.text

        sut.saveButton?.simulateTap()

        XCTAssertEqual(signUpRequest, SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
    }
}
