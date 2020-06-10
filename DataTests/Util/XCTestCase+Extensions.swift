//
//  XCTestCase+Extensions.swift
//  DataTests
//
//  Created by Felipe Ribeiro Mendes on 09/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
