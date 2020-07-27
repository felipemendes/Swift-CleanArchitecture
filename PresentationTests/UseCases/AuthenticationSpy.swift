//
//  AuthenticationSpy.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 27/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation

class AuthenticationSpy: AuthenticationUseCaseProtocol {

    var authentication: Authentication?
    var completion: ((AuthenticationUseCaseProtocol.ServiceReturnType) -> Void)?

    func auth(authentication: Authentication, completion: @escaping (AuthenticationUseCaseProtocol.ServiceReturnType) -> Void) {
        self.authentication = authentication
        self.completion = completion
    }
}
