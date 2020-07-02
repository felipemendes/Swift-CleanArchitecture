//
//  SignUpViewControllerTests.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 01/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }

    func test_sut_conforms_loading_view_protocol() {
        XCTAssertNotNil(makeSut() as LoadingViewProtocol)
    }

    func test_sut_conforms_alert_view_protocol() {
        XCTAssertNotNil(makeSut() as AlertViewProtocol)
    }

    func test_sut_saveButton_calls_signUp_on_tap() {
        var callsCount = 0
        let sut = makeSut(signUpSpy: { _ in callsCount += 1 })

        sut.saveButton?.simulateTap()

        XCTAssertEqual(callsCount, 1)
    }
}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = storyBoard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach({ action in
                (target as NSObject).perform(Selector(action))
            })
        }
    }

    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
