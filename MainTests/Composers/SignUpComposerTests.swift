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
        let (sut, addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let exp = expectation(description: "waiting")

        DispatchQueue.global().async {
            addAccountSpy.completeWith(error: .unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpComposerTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy) {
        let addAccountSpy = AddAccountSpy()
        let sut = SignUpComposer.composerViewController(addAccount: MainQueueDispatchDecorator(addAccountSpy))

        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)

        return (sut, addAccountSpy)
    }
}
