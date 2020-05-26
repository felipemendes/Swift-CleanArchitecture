//
//  HttpPostClientProtocol.swift
//  Data
//
//  Created by Felipe Ribeiro Mendes on 12/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Domain

public protocol HttpPostClientProtocol {
    var url: URL? { get }
    var data: Data? { get }
    var completion: ((MessageError) -> Void)? { get }

    func post(to url: URL, with data: Data?, completion: @escaping (MessageError) -> Void)

    func completeWith(error: MessageError)
}
