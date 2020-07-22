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
    private let emailValidator: EmailValidator
    private let addAccount: AddAccountUseCaseProtocol
    private let loadingView: LoadingViewProtocol

    // MARK: - INITIALIZER

    public init(alertView: AlertViewProtocol,
                emailValidator: EmailValidator,
                addAccount: AddAccountUseCaseProtocol,
                loadingView: LoadingViewProtocol) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }

    // MARK: - PUBLIC API

    public func signUp(signUpViewModel: SignUpViewModel) {
        if let message = validate(signUpViewModel: signUpViewModel) {
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

    // MARK: - PRIVATE FUNCTIONS

    private func validate(signUpViewModel: SignUpViewModel) -> String? {
        if signUpViewModel.name == nil || signUpViewModel.name!.isEmpty {
            return "O campo Nome é obrigatório"
        } else if signUpViewModel.email == nil || signUpViewModel.email!.isEmpty {
            return "O campo Email é obrigatório"
        } else if signUpViewModel.password == nil || signUpViewModel.password!.isEmpty {
            return "O campo Senha é obrigatório"
        } else if signUpViewModel.passwordConfirmation == nil || signUpViewModel.passwordConfirmation!.isEmpty {
            return "O campo Confirmar Senha é obrigatório"
        } else if signUpViewModel.password != signUpViewModel.passwordConfirmation {
            return "O campo Confirmar Senha é inválido"
        }

        if let email = signUpViewModel.email, !emailValidator.isValid(email: email) {
            return "O campo Email é inválido"
        }

        return nil
    }
}
