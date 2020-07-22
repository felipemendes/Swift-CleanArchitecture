//
//  RequiredFieldsValidationTests.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation

class RequiredFieldsValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "E-mail")
        let errorMessage = sut.validate(data: ["name": "Felipe"])
        XCTAssertEqual(errorMessage, "O campo E-mail é obrigatório")
    }

    func test_validate_should_return_error_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "age", fieldLabel: "Idade")
        let errorMessage = sut.validate(data: ["name": "Felipe"])
        XCTAssertEqual(errorMessage, "O campo Idade é obrigatório")
    }

    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "E-mail")
        let errorMessage = sut.validate(data: ["email": "felipe@gmail.com"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "E-mail")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo E-mail é obrigatório")
    }
}
