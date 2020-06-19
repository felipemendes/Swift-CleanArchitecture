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
}

extension MessageError: RawRepresentable {
    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self = .message(rawValue)
    }

    public var rawValue: RawValue {
        switch self {
        case .message(let message): return message
        case .unexpected: return "Unexpected Error"
        case .unauthorized: return "Unauthorized"
        case .forbidden: return "Forbidden"
        case .badRequest: return "Bad Request"
        case .serverError: return "Server Error"
        case .noConnectivity: return "No Connectivity"
        }
    }
}

extension MessageError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .message(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "")
        case .unexpected:
            return NSLocalizedString("Unexpected Error", comment: "")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "")
        case .forbidden:
            return NSLocalizedString("Forbidden", comment: "")
        case .badRequest:
            return NSLocalizedString("Bad Request", comment: "")
        case .serverError:
            return NSLocalizedString("Server Error", comment: "")
        case .noConnectivity:
            return NSLocalizedString("No Connectivity", comment: "")
        }
    }
}
