//
//  SignUpViewController.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 01/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Presentation
import UIKit

public final class SignUpViewController: UIViewController, Storyboarded {

    // MARK: - UI

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: - PUBLIC API

    public var signUp: ((SignUpViewModel) -> Void)?

    // MARK: - LIFE CYCLE

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardOnTap()
    }

    // MARK: - SETUP

    private func setupUI() {
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }

    // MARK: SELECTORS

    @objc private func saveButtonTap() {
        let signUpViewModel = SignUpViewModel(name: nameTextField.text,
                                              email: emailTextField.text,
                                              password: passwordTextField.text,
                                              passwordConfirmation: passwordConfirmationTextField.text)
        signUp?(signUpViewModel)
    }
}

// MARK: - LoadingViewProtocol

extension SignUpViewController: LoadingViewProtocol {
    public func display(loadingViewModel: LoadingViewModel) {
        if loadingViewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

// MARK: - AlertViewProtocol

extension SignUpViewController: AlertViewProtocol {
    public func showMessage(alertViewModel: AlertViewModel) {
        let alert = UIAlertController(title: alertViewModel.title,
                                      message: alertViewModel.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
