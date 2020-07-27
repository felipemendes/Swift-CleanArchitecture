//
//  ValidationComposite.swift
//  Validation
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

public final class ValidationComposite: ValidationProtocol {

    private let validations: [ValidationProtocol]

    public init(validations: [ValidationProtocol]) {
        self.validations = validations
    }

    public func validate(data: [String: Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}
