//
//  SignUpComposerTests.swift
//  MainTests
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Main
import UI
import XCTest

class SignUpComposerTests: XCTestCase {
    func test_background_request_should_complete_on_main_thread() {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()
    }
}

extension SignUpComposerTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy) {
        let addAccountSpy = AddAccountSpy()
        let sut = SignUpComposer.composerViewController(addAccount: addAccountSpy)

        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)

        return (sut, addAccountSpy)
    }
}
