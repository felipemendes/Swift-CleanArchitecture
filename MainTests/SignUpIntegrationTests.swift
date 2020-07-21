//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Main
import XCTest

class SignUpIntegrationTests: XCTestCase {
    func test_ui_presentation_integration() {
        let sut = SignUpComposer.composerViewController(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
