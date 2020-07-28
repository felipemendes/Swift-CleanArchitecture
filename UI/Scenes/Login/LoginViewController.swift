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

    // MARK: - ENUM

    enum PageState {
        case content
        case loading
    }

    // MARK: - PRIVATE PROPERTIES

    private var pageState: PageState = .loading {
        willSet {
            updatePageState(to: newValue)
        }
    }

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

    private func updatePageState(to state: PageState) {
        switch state {
        case .content where pageState != .content:
            view.isUserInteractionEnabled = true
            loginButton.setTitle("Entrar".uppercased(), for: .normal)
            loadingIndicator.stopAnimating()
        case .loading where pageState != .loading:
            view.isUserInteractionEnabled = false
            loginButton.setTitle("Carregando...".uppercased(), for: .normal)
            loadingIndicator.startAnimating()
        default:
            break
        }
    }
}

// MARK: - LoadingViewProtocol

extension LoginViewController: LoadingViewProtocol {
    public func display(loadingViewModel: LoadingViewModel) {
        pageState = loadingViewModel.isLoading ? .loading : .content
    }
}

// MARK: - AlertViewProtocol

extension LoginViewController: AlertViewProtocol {
    public func showMessage(alertViewModel: AlertViewModel) {
        let alert = UIAlertController(title: alertViewModel.title,
                                      message: alertViewModel.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
