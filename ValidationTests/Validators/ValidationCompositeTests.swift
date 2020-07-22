//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {
    func test_validate_should_return_error_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError("Erro 1")
        let errorMessage = sut.validate(data: ["name": "Felipe"])
        XCTAssertEqual(errorMessage, "Erro 1")
    }

    func test_validate_should_return_correct_error_message() {
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2])
        validationSpy2.simulateError("Erro 3")
        let errorMessage = sut.validate(data: ["name": "Felipe"])
        XCTAssertEqual(errorMessage, "Erro 3")
    }

    func test_validate_should_return_the_first_error_message() {
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulateError("Erro 2")
        validationSpy3.simulateError("Erro 3")
        let errorMessage = sut.validate(data: ["name": "Felipe"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }

    func test_validate_should_return_nil_if_validation_succeeds() {
        let sut = makeSut(validations: [ValidationSpy(), ValidationSpy()])
        let errorMessage = sut.validate(data: ["name": "Felipe"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_call_validation_with_correct_data() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name": "Felipe"]
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}
