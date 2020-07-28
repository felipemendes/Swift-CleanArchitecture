//
//  LoginControllerFactory.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation
import Presentation
import UI
import Validation

/// Builds a LoginViewController
///
/// - Parameters:
///   - addAccount: An object that conforms to AuthenticationUseCaseProtocol.
/// - Returns: An instantiated LoginViewController
public func makeLoginViewController(authentication: AuthenticationUseCaseProtocol) -> LoginViewController {
    let loginController = LoginViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(alertView: WeakVarProxy(loginController),
                                   authenticationUseCase: authentication,
                                   loadingView: WeakVarProxy(loginController),
                                   validation: validationComposite)

    loginController.login = presenter.login
    return loginController
}

// MARK: - PUBLIC API

public func makeLoginValidations() -> [ValidationProtocol] {
    var fields = [ValidationProtocol]()
    fields.append(RequiredFieldValidation(fieldName: "email",
                                          fieldLabel: "E-mail"))
    fields.append(EmailValidation(fieldName: "email",
                                  fieldLabel: "E-mail",
                                  emailValidator: makeEmailValidatorAdapter()))
    fields.append(RequiredFieldValidation(fieldName: "password",
                                          fieldLabel: "Senha"))

    return fields
}
