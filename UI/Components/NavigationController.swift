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

    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - PUBLIC API

    public func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
        currentViewController = viewController
        hideBackButtonTest()
    }

    public func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        currentViewController = viewController
        hideBackButtonTest()
    }

    // MARK: - PRIVATE FUNCTIONS

    private func setup() {
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }

    private func hideBackButtonTest() {
        let backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        currentViewController?.navigationItem.backBarButtonItem = backBarButtonItem
    }
}
