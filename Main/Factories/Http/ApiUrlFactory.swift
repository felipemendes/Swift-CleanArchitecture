//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

/// Builds the API URL
///
/// - Returns: An valid URL from remote API
func makeApiUrl(path: String) -> URL {
    guard let baseUrl = Environment.variable(.baseUrl),
        let url = URL(string: "\(baseUrl)/\(path)") else {
            fatalError("Unconstructable \(path) URL")
    }
    return url
}
