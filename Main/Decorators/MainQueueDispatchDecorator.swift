//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation

public final class MainQueueDispatchDecorator<T> {

    private let instance: T

    public init(_ instance: T) {
        self.instance = instance
    }

    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

// MARK: - AddAccountUseCaseProtocol

extension MainQueueDispatchDecorator: AddAccountUseCaseProtocol where T: AddAccountUseCaseProtocol {
    public func add(accountRequest: AccountRequest,
                    completion: @escaping (AddAccountUseCaseProtocol.ServiceReturnType) -> Void) {
        self.instance.add(accountRequest: accountRequest) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

// MARK: - AuthenticationUseCaseProtocol

extension MainQueueDispatchDecorator: AuthenticationUseCaseProtocol where T: AuthenticationUseCaseProtocol {
    public func auth(authentication: Authentication,
                     completion: @escaping (AuthenticationUseCaseProtocol.ServiceReturnType) -> Void) {
        self.instance.auth(authentication: authentication) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
