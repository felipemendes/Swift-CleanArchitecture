//
//  WelcomeViewController.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit

public final class WelcomeViewController: UIViewController, Storyboarded {

    // MARK: - UI

    @IBOutlet weak var loginButton: RoundedButton!
    @IBOutlet weak var sigUpButton: RoundedButton!

    // MARK: - PUBLIC API

    public var login: (() -> Void)?
    public var signUp: (() -> Void)?

    // MARK: - LIFE CYCLE

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - PRIVATE SETUP

    private func setupView() {
        title = "4Dev"
        loginButton.addTarget(self, action: #selector(loginTap), for: .touchUpInside)
        sigUpButton.addTarget(self, action: #selector(sigUpTap), for: .touchUpInside)
    }

    // MARK: SELECTORS

    @objc private func loginTap() {
        login?()
    }

    @objc private func sigUpTap() {
        signUp?()
    }
}
