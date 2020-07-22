//
//  SignUpPresenterTests+Extensions.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation
import Presentation

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewProtocol = AlertViewSpy(),
                 addAccount: AddAccountUseCaseProtocol = AddAccountSpy(),
                 loadingView: LoadingViewSpy = LoadingViewSpy(),
                 validation: ValidationSpy = ValidationSpy(),
                 file: StaticString = #file,
                 line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView,
                                  addAccount: addAccount,
                                  loadingView: loadingView,
                                  validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
