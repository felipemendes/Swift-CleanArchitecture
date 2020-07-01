//
//  TestFactory.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "Felipe",
                         email: String? = "felipe@email.com",
                         password: String? = "123456",
                         passwordConfirmation: String? = "123456") -> SignUpViewModel {
    return SignUpViewModel(name: name,
                           email: email,
                           password: password,
                           passwordConfirmation: passwordConfirmation)
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
}

func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é inválido")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Erro", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso", message: message)
}
