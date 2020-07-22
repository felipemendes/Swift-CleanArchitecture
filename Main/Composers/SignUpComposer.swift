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
        let emailValidatorAdapter = EmailValidatorAdapter()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(signUpController),
                                        emailValidator: emailValidatorAdapter,
                                        addAccount: addAccount,
                                        loadingView: WeakVarProxy(signUpController))

        signUpController.signUp = presenter.signUp
        return signUpController
    }
}
