//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Felipe Ribeiro Mendes on 25/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "felipe@email.com", password: "123456", passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe", password: "123456", passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe", email: "felipe@email.com", passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe", email: "felipe@email.com", password: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo Confirmar Senha é obrigatório"))
    }
}

extension SignUpPresenterTests {
    func makeSut() -> (signUpPresenter: SignUpPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }

    class AlertViewSpy: AlertViewProtocol {
        var alertViewModel: AlertViewModel?

        func showMessage(alertViewModel: AlertViewModel) {
            self.alertViewModel = alertViewModel
        }
    }
}
