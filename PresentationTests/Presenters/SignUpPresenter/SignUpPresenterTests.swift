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
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)

        sut.signUp(signUpViewModel: makeSignUpViewModel(name: nil))

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Nome é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)

        sut.signUp(signUpViewModel: makeSignUpViewModel(email: nil))

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Email é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)

        sut.signUp(signUpViewModel: makeSignUpViewModel(password: nil))

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Senha é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)

        sut.signUp(signUpViewModel: makeSignUpViewModel(passwordConfirmation: nil))

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "O campo Confirmar Senha é obrigatório"))
    }

    func test_signUp_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)

        sut.signUp(signUpViewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "As senhas devem ser iguais"))
    }

    func test_signUp_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()

        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }

    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)

        emailValidatorSpy.isValid = false
        sut.signUp(signUpViewModel: makeSignUpViewModel())

        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação",
                                                                   message: "Email inválido"))
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewProtocol = AlertViewSpy(),
                 emailValidator: EmailValidator = EmailValidatorSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        return sut
    }

    func makeSignUpViewModel(name: String? = "Felipe",
                             email: String? = "invalid@email.com",
                             password: String? = "123456",
                             passwordConfirmation: String? = "123456") -> SignUpViewModel {
        return SignUpViewModel(name: name,
                               email: email,
                               password: password,
                               passwordConfirmation: passwordConfirmation)
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
