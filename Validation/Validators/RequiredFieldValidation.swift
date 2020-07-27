//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

public final class RequiredFieldValidation: ValidationProtocol, Equatable {

    private let fieldName: String
    private let fieldLabel: String

    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }

    public func validate(data: [String: Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String,
            !fieldValue.isEmpty else {
                return "O campo \(fieldLabel) é obrigatório"
        }
        return nil
    }

    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
}
