//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 26/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

public final class SignUpPresenter {

    // MARK: - PRIVATE PROPERTIES

    private let alertView: AlertViewProtocol
    private let addAccountUseCase: AddAccountUseCaseProtocol
    private let loadingView: LoadingViewProtocol
    private let validation: ValidationProtocol

    // MARK: - INITIALIZER

    public init(alertView: AlertViewProtocol,
                addAccountUseCase: AddAccountUseCaseProtocol,
                loadingView: LoadingViewProtocol,
                validation: ValidationProtocol) {
        self.alertView = alertView
        self.addAccountUseCase = addAccountUseCase
        self.loadingView = loadingView
        self.validation = validation
    }

    // MARK: - PUBLIC API

    public func signUp(signUpViewModel: SignUpViewModel) {
        if let message = validation.validate(data: signUpViewModel.toJson()) {
            alertView.showMessage(alertViewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            guard let accountRequest = signUpViewModel.toAccountRequest() else { return }

            loadingView.display(loadingViewModel: LoadingViewModel(isLoading: true))
            addAccountUseCase.add(accountRequest: accountRequest) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(loadingViewModel: LoadingViewModel(isLoading: false))

                switch result {
                case .success:
                    self.alertView.showMessage(alertViewModel: AlertViewModel(title: "Sucesso",
                                                                              message: "Conta criada com sucesso."))
                case .failure(let error):
                    var errorMessage = ""
                    switch error {
                    case .emailInUse:
                        errorMessage = "Esse e-mail já está em uso."
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
