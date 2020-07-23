//
//  RoundedButton.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 23/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit

public final class RoundedButton: UIButton {

    // MARK: - INITIALIZER

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - PRIVATE FUNCTIONS

    private func setup() {
        layer.cornerRadius = 5
    }
}
