//
//  MessageError.swift
//  Domain
//
//  Created by Felipe Ribeiro Mendes on 16/05/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public enum MessageError: Error, Equatable {
    case message(String)
    case unexpected
    case unauthorized
    case forbidden
    case badRequest
    case serverError
    case noConnectivity
    case emailInUse
}
