//
//  LoginViewControllerFactoryTests.swift
//  MainTests
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Main
import UI
import Validation
import XCTest

class LoginViewControllerFactoryTests: XCTestCase {
    func test_login_compose_with_correct_validations() {
        let validations = makeSignUpValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "E-mail"))
        XCTAssertEqual(validations[1] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "E-mail", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validations[2] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"))
    }
}

extension LoginViewControllerFactoryTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: LoginViewController, authenticationSpy: AuthenticationSpy) {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeLoginViewController(authentication: authenticationSpy)

        checkMemoryLeak(for: authenticationSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)

        return (sut, authenticationSpy)
    }
}
