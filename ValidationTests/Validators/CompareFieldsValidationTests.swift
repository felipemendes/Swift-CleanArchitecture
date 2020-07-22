//
//  CompareFieldsValidationTests.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation

class CompareFieldsValidationTests: XCTestCase {
    func test_validate_should_return_error_if_comparation_fails() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "123456"])
        XCTAssertEqual(errorMessage, "O campo Senha é inválido")
    }

    func test_validate_should_return_error_with_correct_field_label() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "123456"])
        XCTAssertEqual(errorMessage, "O campo Confirmar Senha é inválido")
    }

    func test_validate_should_return_nil_if_comparation_succeeds() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "123"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Senha é inválido")
    }
}
