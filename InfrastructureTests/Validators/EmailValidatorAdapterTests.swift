//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 16/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Infrastructure

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "aa"))
        XCTAssertFalse(sut.isValid(email: "aa@"))
        XCTAssertFalse(sut.isValid(email: "aa@bb"))
        XCTAssertFalse(sut.isValid(email: "aa@bb."))
        XCTAssertFalse(sut.isValid(email: "@bb.com"))
    }

    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "teste@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "teste@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "teste@hotmail.com.br"))
    }
}
