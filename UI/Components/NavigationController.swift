//
//  NavigationController.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 23/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit

public final class NavigationController: UINavigationController {

    // MARK: - PRIVATE PROPERTIES

    private var currentViewController: UIViewController?

    // MARK: - INITIALIZERS

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - PRIVATE FUNCTIONS

    private func setup() {
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
}
