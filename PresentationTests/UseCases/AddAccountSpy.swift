//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation

class AddAccountSpy: AddAccountUseCaseProtocol {

    var accountRequest: AccountRequest?
    var completion: ((AddAccountUseCaseProtocol.ServiceReturnType) -> Void)?

    func add(accountRequest: AccountRequest, completion: @escaping (AddAccountUseCaseProtocol.ServiceReturnType) -> Void) {
        self.accountRequest = accountRequest
        self.completion = completion
    }

    func completeWith(error: MessageError) {
        completion?(.failure(error))
    }

    func completeWith(account: AccountResponse) {
        completion?(.success(account))
    }
}
