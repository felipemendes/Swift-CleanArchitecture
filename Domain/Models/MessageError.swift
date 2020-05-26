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
}

extension MessageError: RawRepresentable {
    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self = .message(rawValue)
    }

    public var rawValue: RawValue {
        switch self {
        case .message(let message): return message
        }
    }
}

extension MessageError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .message(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "")
        }
    }
}
