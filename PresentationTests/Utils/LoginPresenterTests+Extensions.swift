//
//  LoginPresenterTests+Extensions.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 27/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation
import Presentation

extension LoginPresenterTests {
    func makeSut(alertView: AlertViewProtocol = AlertViewSpy(),
                 authenticationUseCase: AuthenticationUseCaseProtocol = AuthenticationSpy(),
                 loadingView: LoadingViewSpy = LoadingViewSpy(),
                 validation: ValidationSpy = ValidationSpy(),
                 file: StaticString = #file,
                 line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(alertView: alertView,
                                 authenticationUseCase: authenticationUseCase,
                                 loadingView: loadingView,
                                 validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
