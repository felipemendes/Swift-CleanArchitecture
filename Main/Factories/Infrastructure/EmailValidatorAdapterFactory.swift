//
//  EmailValidatorAdapterFactory.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Infrastructure

/// Builds a EmailValidatorAdapter
///
/// - Returns: An instantiated EmailValidatorAdapter
func makeEmailValidatorAdapter() -> EmailValidatorAdapter {
    return EmailValidatorAdapter()
}
