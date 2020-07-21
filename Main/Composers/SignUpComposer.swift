//
//  SignUpComposer.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Domain
import Foundation
import UI

public final class SignUpComposer {
    static func composerViewController(addAccount: AddAccountUseCaseProtocol) -> SignUpViewController {
        return ControllerFactory.makeSignUpController(addAccount: addAccount)
    }
}
