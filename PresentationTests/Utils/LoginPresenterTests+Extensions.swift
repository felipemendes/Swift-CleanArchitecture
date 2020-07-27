//
//  LoginPresenterTests+Extensions.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 27/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation
import Presentation

extension LoginPresenterTests {
    func makeSut(validation: ValidationSpy = ValidationSpy(),
                 file: StaticString = #file,
                 line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
