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
    func test_signUp_should_call_addAccount_with_correct_data() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountUseCase: addAccountSpy)

        sut.signUp(signUpViewModel: makeSignUpViewModel())

        XCTAssertEqual(addAccountSpy.accountRequest, makeAccountRequest())
    }

    func test_signUp_should_show_generic_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccountUseCase: addAccountSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu."))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel())
        addAccountSpy.completeWith(error: .unexpected)
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_email_in_use_error_message_if_addAccount_returns_email_in_use_error() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccountUseCase: addAccountSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Esse e-mail já está em uso."))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel())
        addAccountSpy.completeWith(error: .emailInUse)
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_success_message_if_addAccount_succedds() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccountUseCase: addAccountSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
            exp.fulfill()
        }

        sut.signUp(signUpViewModel: makeSignUpViewModel())
        addAccountSpy.completeWith(account: makeAccountResponse())
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_loading_before_and_after_addAccount_been_call() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountUseCase: addAccountSpy, loadingView: loadingViewSpy)

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

    func test_signUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()

        sut.signUp(signUpViewModel: viewModel)

        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }

    func test_signUp_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }

        validationSpy.simulateError()
        sut.signUp(signUpViewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
}
