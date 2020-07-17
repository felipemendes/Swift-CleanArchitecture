//
//  UIViewController+Extensions.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 16/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
