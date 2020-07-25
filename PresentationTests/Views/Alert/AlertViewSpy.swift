//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

class AlertViewSpy: AlertViewProtocol {
    
    var emit: ((AlertViewModel) -> Void)?

    func observer(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }

    func showMessage(alertViewModel: AlertViewModel) {
        self.emit?(alertViewModel)
    }
}
