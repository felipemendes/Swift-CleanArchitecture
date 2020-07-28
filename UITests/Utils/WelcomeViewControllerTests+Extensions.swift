//
//  WelcomeViewControllerTests+Extensions.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import UI

extension WelcomeViewControllerTests {
    func makeSut() -> (sut: WelcomeViewController, buttonSpy: ButtonSpy) {
        let buttonSpy = ButtonSpy()
        let sut = WelcomeViewController.instantiate()

        sut.login = buttonSpy.onClick
        sut.signUp = buttonSpy.onClick
        sut.loadViewIfNeeded()

        checkMemoryLeak(for: sut)

        return (sut, buttonSpy)
    }

    class ButtonSpy {
        var clicks = 0
        func onClick() { clicks += 1 }
    }
}
