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
    private let loadingView: LoadingViewProtocol
    private let validation: ValidationProtocol

    // MARK: - INITIALIZER

    public init(alertView: AlertViewProtocol,
                authenticationUseCase: AuthenticationUseCaseProtocol,
                loadingView: LoadingViewProtocol,
                validation: ValidationProtocol) {
        self.alertView = alertView
        self.authenticationUseCase = authenticationUseCase
        self.loadingView = loadingView
        self.validation = validation
    }

    // MARK: - PUBLIC API

    public func login(loginViewModel: LoginViewModel) {
        if let message = validation.validate(data: loginViewModel.toJson()) {
            alertView.showMessage(alertViewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            guard let authentication = loginViewModel.toAuthentication() else { return }

            loadingView.display(loadingViewModel: LoadingViewModel(isLoading: true))
            authenticationUseCase.auth(authentication: authentication) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(loadingViewModel: LoadingViewModel(isLoading: false))

                switch result {
                case .success:
                    self.alertView.showMessage(alertViewModel: AlertViewModel(title: "Sucesso",
                                                                              message: "Login realizado com sucesso."))
                case .failure(let error):
                    var errorMessage = ""
                    switch error {
                    case .expiredSession:
                        errorMessage = "E-mail e/ou senha inválido(s)."
                    default:
                        errorMessage = "Algo inesperado aconteceu."
                    }
                    self.alertView.showMessage(alertViewModel: AlertViewModel(title: "Erro",
                                                                              message: errorMessage))
                }
            }
        }
    }
}
