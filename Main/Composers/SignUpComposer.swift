//
//  SignUpComposer.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Foundation
import Infrastructure
import Presentation
import UI
import Validation

public final class SignUpComposer {

    // MARK: - FACTORIES

    /// Builds a SignUpViewController
    ///
    /// - Parameters:
    ///   - addAccount: An object that conforms to AddAccountUseCaseProtocol.
    /// - Returns: An instantiated SignUpViewController
    public static func composerViewController(addAccount: AddAccountUseCaseProtocol) -> SignUpViewController {
        let signUpController = SignUpViewController.instantiate()
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = SignUpPresenter(alertView: WeakVarProxy(signUpController),
                                        addAccount: addAccount,
                                        loadingView: WeakVarProxy(signUpController), validation: validationComposite)

        signUpController.signUp = presenter.signUp
        return signUpController
    }
}

// MARK: - HELPERS

extension SignUpComposer {
    public static func makeValidations() -> [Validation] {
        var fields = [Validation]()
        fields.append(RequiredFieldValidation(fieldName: "name",
                                              fieldLabel: "Nome"))
        fields.append(RequiredFieldValidation(fieldName: "email",
                                              fieldLabel: "E-mail"))
        fields.append(EmailValidation(fieldName: "email",
                                      fieldLabel: "E-mail",
                                      emailValidator: EmailValidatorAdapter()))
        fields.append(RequiredFieldValidation(fieldName: "password",
                                              fieldLabel: "Senha"))
        fields.append(RequiredFieldValidation(fieldName: "passwordConfirmation",
                                              fieldLabel: "Confirmar Senha"))
        fields.append(CompareFieldValidation(fieldName: "password",
                                             fieldNameToCompare: "passwordConfirmation",
                                             fieldLabel: "Confirmar Senha"))

        return fields
    }
}
