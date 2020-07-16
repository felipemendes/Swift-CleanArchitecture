//
//  UIControl+Extensions.swift
//  UITests
//
//  Created by Felipe Ribeiro Mendes on 15/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach({ action in
                (target as NSObject).perform(Selector(action))
            })
        }
    }

    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
