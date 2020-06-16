//
//  TestFactory.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 12/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

func makeUrl() -> URL {
    return URL(string: "http://url.com")!
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Felip\"}".utf8)
}

func makeInvalidData() -> Data {
    return Data("invalid_json".utf8)
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}
