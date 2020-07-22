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
    private let addAccount: AddAccountUseCaseProtocol
    private let loadingView: LoadingViewProtocol
    private let validation: Validation

    // MARK: - INITIALIZER

    public init(alertView: AlertViewProtocol,
                addAccount: AddAccountUseCaseProtocol,
                loadingView: LoadingViewProtocol,
                validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }

    // MARK: - PUBLIC API

    public func signUp(signUpViewModel: SignUpViewModel) {
        if let message = validation.validate(data: signUpViewModel.toJson()) {
            alertView.showMessage(alertViewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            guard let accountRequest = SignUpMapper.toAddAccount(signUpViewModel: signUpViewModel) else { return }

            loadingView.display(loadingViewModel: LoadingViewModel(isLoading: true))
            addAccount.add(accountRequest: accountRequest) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(loadingViewModel: LoadingViewModel(isLoading: false))

                switch result {
                case .success:
                    self.alertView.showMessage(alertViewModel: AlertViewModel(title: "Sucesso",
                                                                              message: "Conta criada com sucesso."))
                case .failure:
                    self.alertView.showMessage(alertViewModel: AlertViewModel(title: "Erro",
                                                                              message: "Algo inesperado aconteceu."))
                }
            }
        }
    }
}
