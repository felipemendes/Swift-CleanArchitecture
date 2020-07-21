//
//  Environment.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public final class Environment {

    public enum EnvironmentVariables: String {
        case baseUrl = "BASE_URL"
    }

    public static func variable(_ key: EnvironmentVariables) -> String? {
        return Bundle.main.infoDictionary?[key.rawValue] as? String
    }
}
