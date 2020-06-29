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

    // MARK: - INITIALIZER

    public init(alertView: AlertViewProtocol,
                emailValidator: EmailValidator,
                addAccount: AddAccountUseCaseProtocol) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    }

    // MARK: - PUBLIC API

    public func signUp(signUpViewModel: SignUpViewModel) {
        if let message = validate(signUpViewModel: signUpViewModel) {
            alertView.showMessage(alertViewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            guard let name = signUpViewModel.name,
                let email = signUpViewModel.email,
                let password = signUpViewModel.password,
                let passwordConfirmation = signUpViewModel.passwordConfirmation else { return }

            let accountRequest = AccountRequest(name: name,
                                                email: email,
                                                password: password,
                                                passwordConfirmation: passwordConfirmation)
            addAccount.add(accountRequest: accountRequest) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    break
                case .failure:
                    self.alertView.showMessage(alertViewModel: AlertViewModel(title: "Erro",
                                                                              message: "Algo inesperado aconteceu. Tente novamente em alguns instantes."))
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
