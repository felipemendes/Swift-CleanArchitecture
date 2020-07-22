//
//  EmailValidationTests+Extensions.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation
import Validation

extension EmailValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorSpy, file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
