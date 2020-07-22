//
//  ValidationCompositeTests+Extensions.swift
//  ValidationTests
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation
import Validation

extension ValidationCompositeTests {
    func makeSut(validations: [ValidationSpy], file: StaticString = #file, line: UInt = #line) -> Validation {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
