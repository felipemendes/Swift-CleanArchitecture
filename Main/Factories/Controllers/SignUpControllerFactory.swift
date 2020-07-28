//
//  SignUpControllerFactory.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation
import Presentation
import UI
import Validation

/// Builds a SignUpViewController
///
/// - Parameters:
///   - addAccount: An object that conforms to AddAccountUseCaseProtocol.
/// - Returns: An instantiated SignUpViewController
public func makeSignUpViewController(addAccount: AddAccountUseCaseProtocol) -> SignUpViewController {
    let signUpController = SignUpViewController.instantiate()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    let presenter = SignUpPresenter(alertView: WeakVarProxy(signUpController),
                                    addAccountUseCase: addAccount,
                                    loadingView: WeakVarProxy(signUpController), validation: validationComposite)

    signUpController.signUp = presenter.signUp
    return signUpController
}

// MARK: - PUBLIC API

public func makeSignUpValidations() -> [ValidationProtocol] {
    var fields = [ValidationProtocol]()
    fields.append(RequiredFieldValidation(fieldName: "name",
                                          fieldLabel: "Nome"))
    fields.append(RequiredFieldValidation(fieldName: "email",
                                          fieldLabel: "E-mail"))
    fields.append(EmailValidation(fieldName: "email",
                                  fieldLabel: "E-mail",
                                  emailValidator: makeEmailValidatorAdapter()))
    fields.append(RequiredFieldValidation(fieldName: "password",
                                          fieldLabel: "Senha"))
    fields.append(RequiredFieldValidation(fieldName: "passwordConfirmation",
                                          fieldLabel: "Confirmar Senha"))
    fields.append(CompareFieldValidation(fieldName: "password",
                                         fieldNameToCompare: "passwordConfirmation",
                                         fieldLabel: "Confirmar Senha"))

    return fields
}
