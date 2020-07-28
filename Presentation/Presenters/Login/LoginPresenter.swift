//
//  LoginPresenter.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 27/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

public final class LoginPresenter {

    // MARK: - PRIVATE PROPERTIES

    private let alertView: AlertViewProtocol
    private let authenticationUseCase: AuthenticationUseCaseProtocol
    private let validation: ValidationProtocol

    // MARK: - INITIALIZER

    public init(alertView: AlertViewProtocol,
                authenticationUseCase: AuthenticationUseCaseProtocol,
                validation: ValidationProtocol) {
        self.alertView = alertView
        self.authenticationUseCase = authenticationUseCase
        self.validation = validation
    }

    // MARK: - PUBLIC API

    public func login(loginViewModel: LoginViewModel) {
        if let message = validation.validate(data: loginViewModel.toJson()) {
            alertView.showMessage(alertViewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            guard let authentication = loginViewModel.toAuthentication() else { return }

            authenticationUseCase.auth(authentication: authentication) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success:
                    break
                case .failure:
                    self.alertView.showMessage(alertViewModel: AlertViewModel(title: "Erro",
                                                                              message: "Algo inesperado aconteceu."))
                }
            }
        }
    }
}
