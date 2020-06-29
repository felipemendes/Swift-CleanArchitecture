//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Felipe Ribeiro Mendes on 25/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Nome"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Email"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Senha"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_confirmation_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
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

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Email"))
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

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(message: "Algo inesperado aconteceu. Tente novamente em alguns instantes."))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel())
        addAccountSpy.completeWith(error: .unexpected)
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewProtocol = AlertViewSpy(),
                 emailValidator: EmailValidator = EmailValidatorSpy(),
                 addAccount: AddAccountUseCaseProtocol = AddAccountSpy(),
                 file: StaticString = #file,
                 line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }

    func makeSignUpViewModel(name: String? = "Felipe",
                             email: String? = "felipe@email.com",
                             password: String? = "123456",
                             passwordConfirmation: String? = "123456") -> SignUpViewModel {
        return SignUpViewModel(name: name,
                               email: email,
                               password: password,
                               passwordConfirmation: passwordConfirmation)
    }

    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
    }

    func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é inválido")
    }

    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: message)
    }

    class AlertViewSpy: AlertViewProtocol {
        var emit: ((AlertViewModel) -> Void)?

        func observer(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }

        func showMessage(alertViewModel: AlertViewModel) {
            self.emit?(alertViewModel)
        }
    }

    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?

        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }

        func simulateInvalidEmail() {
            isValid = false
        }
    }

    class AddAccountSpy: AddAccountUseCaseProtocol {
        var accountRequest: AccountRequest?
        var completion: ((Result<AccountResponse, MessageError>) -> Void)?

        func add(accountRequest: AccountRequest, completion: @escaping (Result<AccountResponse, MessageError>) -> Void) {
            self.accountRequest = accountRequest
            self.completion = completion
        }

        func completeWith(error: MessageError) {
            completion?(.failure(error))
        }
    }
}
