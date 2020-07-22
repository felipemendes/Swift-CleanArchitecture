//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation
import Validation

class EmailValidationTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }

    func test_validate_should_return_error_with_correct_fieldLabel() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "O campo Email2 é inválido")
    }

    func test_validate_should_return_nil_if_valid_email_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: EmailValidatorSpy())
        let errorMessage = sut.validate(data: ["email": "valid_email@gmail.com"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy())
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }
}
