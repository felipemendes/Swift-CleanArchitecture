//
//  ValidationProtocol.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 22/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public protocol ValidationProtocol {
    func validate(data: [String: Any]?) -> String?
}
