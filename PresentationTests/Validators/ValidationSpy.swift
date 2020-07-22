//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?

    func validate(data: [String: Any]?) -> String? {
        self.data = data
        return errorMessage
    }

    func simulateError() {
        self.errorMessage = "Erro"
    }
}
