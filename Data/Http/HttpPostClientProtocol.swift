//
//  HttpPostClientProtocol.swift
//  Data
//
//  Created by Felipe Ribeiro Mendes on 12/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public protocol HttpPostClientProtocol {
    var url: URL? { get }
    var data: Data? { get }

    func post(to url: URL, with data: Data?)
}
