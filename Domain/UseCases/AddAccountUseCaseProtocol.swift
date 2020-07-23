//
//  AddAccountUseCaseProtocol.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public protocol AddAccountUseCaseProtocol {
    typealias ServiceReturnType = Result<AccountResponse, MessageError>
    func add(accountRequest: AccountRequest, completion: @escaping (ServiceReturnType) -> Void)
}
