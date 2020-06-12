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

func makeInvalidData() -> Data {
    return Data("invalid_json".utf8)
}
