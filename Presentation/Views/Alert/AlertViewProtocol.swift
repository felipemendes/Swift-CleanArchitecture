//
//  AlertViewProtocol.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 26/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public protocol AlertViewProtocol {
    var emit: ((AlertViewModel) -> Void)? { get }

    func observer(completion: @escaping (AlertViewModel) -> Void)
    func showMessage(alertViewModel: AlertViewModel)
}
