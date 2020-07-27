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

    private let validation: Validation

    // MARK: - INITIALIZER

    public init(validation: Validation) {
        self.validation = validation
    }

    // MARK: - PUBLIC API

    public func login(loginViewModel: LoginViewModel) {
        _ = validation.validate(data: loginViewModel.toJson())
    }
}
