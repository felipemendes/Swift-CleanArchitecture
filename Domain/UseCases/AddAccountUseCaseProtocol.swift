//
//  AddAccountUseCaseProtocol.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 11/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

protocol AddAccountUseCaseProtocol {
    func add(AddAccount: AddAccount, completion: @escaping (Result<Account, Error>) -> Void)
}

