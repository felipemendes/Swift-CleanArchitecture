//
//  LoginViewController.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 28/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Presentation
import UIKit

public final class LoginViewController: UIViewController, Storyboarded {

    // MARK: - UI

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var loginButton: RoundedButton!

    // MARK: - LIFE CYCLE

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboardOnTap()
    }

    // MARK: - PRIVATE SETUP

    private func setupView() {
        title = "4Dev"
    }
}
