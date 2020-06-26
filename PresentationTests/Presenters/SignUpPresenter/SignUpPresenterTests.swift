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
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "felipe@email.com",
                                              password: "123456",
                                              passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Nome é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe",
                                              password: "123456",
                                              passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Email é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe",
                                              email: "felipe@email.com",
                                              passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Senha é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe",
                                              email: "felipe@email.com",
                                              password: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Confirmar Senha é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_confirmation_not_match() {
        let (sut, alertViewSpy, _) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe",
                                              email: "felipe@email.com",
                                              password: "123456",
                                              passwordConfirmation: "123")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "As senhas devem ser iguais"))
    }

    func test_signUp_should_call_emailValidator_with_correct_email() {
        let (sut, _, emailValidatorSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe",
                                              email: "invalid@email.com",
                                              password: "123456",
                                              passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }

    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let (sut, alertViewSpy, emailValidatorSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "Felipe",
                                              email: "invalid@email.com",
                                              password: "123456",
                                              passwordConfirmation: "123456")
        emailValidatorSpy.isValid = false
        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "Email inválido"))
    }
}

extension SignUpPresenterTests {
    func makeSut() -> (signUpPresenter: SignUpPresenter, alertViewSpy: AlertViewSpy, emailValidatorSpy: EmailValidatorSpy) {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        return (sut, alertViewSpy, emailValidatorSpy)
    }

    class AlertViewSpy: AlertViewProtocol {
        var alertViewModel: AlertViewModel?

        func showMessage(alertViewModel: AlertViewModel) {
            self.alertViewModel = alertViewModel
        }
    }

    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?

        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
    }
}
