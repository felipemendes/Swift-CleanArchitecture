//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Validation

class EmailValidatorSpy: EmailValidator {
    
    var isValid = true
    var email: String?

    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }

    func simulateInvalidEmail() {
        isValid = false
    }
}
