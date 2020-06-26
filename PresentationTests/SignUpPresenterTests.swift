//
//  SignUpPresenterTests.swift
//  SignUpPresenterTests
//
//  Created by Felipe Ribeiro Mendes on 25/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest

class SignUpPresenter {

    // MARK: - PRIVATE PROPERTIES

    private let alertView: AlertView

    // MARK: - INITIALIZER

    init(alertView: AlertView) {
        self.alertView = alertView
    }

    // MARK: - PUBLIC API

    func signUp(signUpViewModel: SignUpViewModel) {
        if signUpViewModel.name == nil || signUpViewModel.name!.isEmpty {
            alertView.showMessage(alertViewModel: AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
        }
    }
}

protocol AlertView {
    var alertViewModel: AlertViewModel? { get }
    func showMessage(alertViewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    let title: String
    let message: String
}

struct SignUpViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        let signUpViewModel = SignUpViewModel(email: "felipe@email.com", password: "123456", passwordConfirmation: "123456")
        sut.signUp(signUpViewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.alertViewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
    }
}

extension SignUpPresenterTests {
    class AlertViewSpy: AlertView {
        var alertViewModel: AlertViewModel?

        func showMessage(alertViewModel: AlertViewModel) {
            self.alertViewModel = alertViewModel
        }
    }
}
