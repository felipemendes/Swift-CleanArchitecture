//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 16/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation

public final class EmailValidatorAdapter: EmailValidator {

    // MARK: - PRIVATE PROPERTIES

    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    // MARK: - PUBLIC API

    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertFalse(sut.isValid(email: "aa"))
        XCTAssertFalse(sut.isValid(email: "aa@"))
        XCTAssertFalse(sut.isValid(email: "aa@bb"))
        XCTAssertFalse(sut.isValid(email: "aa@bb."))
        XCTAssertFalse(sut.isValid(email: "@bb.com"))
    }
}
