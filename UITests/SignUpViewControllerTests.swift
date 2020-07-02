//
//  SignUpViewControllerTests.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 01/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
}
