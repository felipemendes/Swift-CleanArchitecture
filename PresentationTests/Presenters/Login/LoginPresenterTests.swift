//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 27/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation

class LoginPresenterTests: XCTestCase {
    func test_login_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()

        sut.login(loginViewModel: viewModel)

        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }

    func test_login_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }

        validationSpy.simulateError()
        sut.login(loginViewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }

    func test_login_should_call_authentication_with_correct_data() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationUseCase: authenticationSpy)

        sut.login(loginViewModel: makeLoginViewModel())

        XCTAssertEqual(authenticationSpy.authentication, makeAuthentication())
    }

    func test_login_should_show_generic_error_message_if_authentication_fails() {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authenticationUseCase: authenticationSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu."))
            exp.fulfill()
        }

        sut.login(loginViewModel: makeLoginViewModel())
        authenticationSpy.completeWith(error: .unexpected)
        wait(for: [exp], timeout: 1)
    }

    func test_login_should_show_expiredSession_error_message_if_authentication_completes_with_expiredSession() {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authenticationUseCase: authenticationSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "E-mail e/ou senha inválido(s)."))
            exp.fulfill()
        }

        sut.login(loginViewModel: makeLoginViewModel())
        authenticationSpy.completeWith(error: .expiredSession)
        wait(for: [exp], timeout: 1)
    }

    func test_login_should_show_success_message_if_authentication_succedds() {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authenticationUseCase: authenticationSpy)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Login realizado com sucesso."))
            exp.fulfill()
        }

        sut.login(loginViewModel: makeLoginViewModel())
        authenticationSpy.completeWith(account: makeAccountResponse())
        wait(for: [exp], timeout: 1)
    }
}
