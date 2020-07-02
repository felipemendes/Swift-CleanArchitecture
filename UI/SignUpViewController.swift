//
//  SignUpViewController.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 01/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Presentation
import UIKit

final class SignUpViewController: UIViewController {

    // MARK: - UI

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: - PUBLIC API

    var signUp: ((SignUpViewModel) -> Void)?

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - SETUP

    private func setupUI() {
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }

    // MARK: SELECTORS

    @objc private func saveButtonTap() {
        signUp?(SignUpViewModel(name: nil, email: nil, password: nil, passwordConfirmation: nil))
    }
}

// MARK: - LoadingViewProtocol

extension SignUpViewController: LoadingViewProtocol {
    func display(loadingViewModel: LoadingViewModel) {
        if loadingViewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

// MARK: - AlertViewProtocol

extension SignUpViewController: AlertViewProtocol {
    func showMessage(alertViewModel: AlertViewModel) { }
}
