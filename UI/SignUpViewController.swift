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

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
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
