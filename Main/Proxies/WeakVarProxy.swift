//
//  WeakVarProxy.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Presentation

final class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?

    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertViewProtocol where T: AlertViewProtocol {
    func showMessage(alertViewModel: AlertViewModel) {
        instance?.showMessage(alertViewModel: alertViewModel)
    }
}

extension WeakVarProxy: LoadingViewProtocol where T: LoadingViewProtocol {
    func display(loadingViewModel: LoadingViewModel) {
        instance?.display(loadingViewModel: loadingViewModel)
    }
}
