//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Felipe Ribeiro Mendes on 30/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingViewProtocol {
    var emit: ((LoadingViewModel) -> Void)?

    func observer(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }

    func display(loadingViewModel: LoadingViewModel) {
        self.emit?(loadingViewModel)
    }
}
