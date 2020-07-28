//
//  LoginViewControllerTests+Extensions.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation
@testable import UI

extension LoginViewControllerTests {
    func makeSut(loginSpy: ((LoginRequest) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController.instantiate()
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return sut
    }
}
