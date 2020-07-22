//
//  RequiredFieldsValidationTests+Extensions.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Presentation
import Validation

extension RequiredFieldsValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
