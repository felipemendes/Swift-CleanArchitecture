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
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Nome"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Senha"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer {  viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }

        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(signUpViewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()

        sut.signUp(signUpViewModel: signUpViewModel)

        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }

    func test_signUp_should_call_addAccount_with_correct_data() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)

        sut.signUp(signUpViewModel: makeSignUpViewModel())

        XCTAssertEqual(addAccountSpy.accountRequest, makeAccountRequest())
    }

    func test_signUp_should_show_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Algo inesperado aconteceu."))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel())
        addAccountSpy.completeWith(error: .unexpected)
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_success_message_if_addAccount_succedds() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Conta criada com sucesso."))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel())
        addAccountSpy.completeWith(account: makeAccountResponse())
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_loading_before_and_after_addAccount_been_call() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)

        let expBefore = expectation(description: "waiting LoadingView before")
        loadingViewSpy.observer { loadingViewModel in
            XCTAssertEqual(loadingViewModel, LoadingViewModel(isLoading: true))
            expBefore.fulfill()
        }
        sut.signUp(signUpViewModel: makeSignUpViewModel())
        wait(for: [expBefore], timeout: 1)

        let expAfter = expectation(description: "waiting LoadingView after")
        loadingViewSpy.observer { loadingViewModel in
            XCTAssertEqual(loadingViewModel, LoadingViewModel(isLoading: false))
            expAfter.fulfill()
        }
        addAccountSpy.completeWith(error: .unexpected)
        wait(for: [expAfter], timeout: 1)
    }
}
