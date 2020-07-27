//
//  EmailValidation.swift
//  Validation
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

public final class EmailValidation: ValidationProtocol, Equatable {

    private let fieldName: String
    private let fieldLabel: String
    private let emailValidator: EmailValidator

    public init(fieldName: String, fieldLabel: String, emailValidator: EmailValidator) {
        self.fieldLabel = fieldLabel
        self.fieldName = fieldName
        self.emailValidator = emailValidator
    }

    public func validate(data: [String: Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String,
            emailValidator.isValid(email: fieldValue) else {
                return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }

    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
}
