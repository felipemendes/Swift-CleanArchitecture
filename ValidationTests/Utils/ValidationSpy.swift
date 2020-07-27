//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

class ValidationSpy: ValidationProtocol {
    
    var errorMessage: String?
    var data: [String: Any]?

    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }

    func simulateError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
