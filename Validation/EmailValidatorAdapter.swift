//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Felipe Ribeiro Mendes on 16/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

public final class EmailValidatorAdapter: EmailValidator {

    // MARK: - PRIVATE PROPERTIES

    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    // MARK: - INITIALIZER

    public init() { }

    // MARK: - PUBLIC API

    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try? NSRegularExpression(pattern: pattern)
        return regex?.firstMatch(in: email, options: [], range: range) != nil
    }
}
