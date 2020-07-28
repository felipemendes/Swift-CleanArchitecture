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
        let request = makeLoginRequest()
        
        sut.login(loginRequest: request)
        
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: request.toJson()!))
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
        sut.login(loginRequest: makeLoginRequest())
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_call_authentication_with_correct_data() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationUseCase: authenticationSpy)
        
        sut.login(loginRequest: makeLoginRequest())
        
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
        
        sut.login(loginRequest: makeLoginRequest())
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
        
        sut.login(loginRequest: makeLoginRequest())
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
        
        sut.login(loginRequest: makeLoginRequest())
        authenticationSpy.completeWith(account: makeAccountResponse())
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_loading_before_and_after_authentication_been_call() {
        let loadingViewSpy = LoadingViewSpy()
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authenticationUseCase: authenticationSpy, loadingView: loadingViewSpy)
        
        let expBefore = expectation(description: "waiting LoadingView before")
        loadingViewSpy.observer { loadingViewModel in
            XCTAssertEqual(loadingViewModel, LoadingViewModel(isLoading: true))
            expBefore.fulfill()
        }
        sut.login(loginRequest: makeLoginRequest())
        wait(for: [expBefore], timeout: 1)
        
        let expAfter = expectation(description: "waiting LoadingView after")
        loadingViewSpy.observer { loadingViewModel in
            XCTAssertEqual(loadingViewModel, LoadingViewModel(isLoading: false))
            expAfter.fulfill()
        }
        authenticationSpy.completeWith(error: .unexpected)
        wait(for: [expAfter], timeout: 1)
    }
}
