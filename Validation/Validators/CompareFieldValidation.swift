//
//  CompareFieldValidation.swift
//  Validation
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

public final class CompareFieldValidation: Validation, Equatable {

    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String

    public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldLabel = fieldLabel
    }

    public func validate(data: [String: Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String,
            let fieldNameToCompare = data?[fieldNameToCompare] as? String,
            fieldValue == fieldNameToCompare else {
                return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }

    public static func == (lhs: CompareFieldValidation, rhs: CompareFieldValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel
            && lhs.fieldNameToCompare == rhs.fieldNameToCompare
            && lhs.fieldName == rhs.fieldName
    }
}
