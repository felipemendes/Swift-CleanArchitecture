//
//  SceneDelegate.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let signUpFactory: () -> SignUpViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        let addAccount = makeAddAccount(httpClient: alamofireAdapter)
        return makeSignUpViewController(addAccount: addAccount)
    }

    private let loginFactory: () -> LoginViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        let authentication = makeAuthentication(httpClient: alamofireAdapter)
        return makeLoginViewController(authentication: authentication)
    }

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let navigation = NavigationController()
        let welcomeRouter = WelcomeRouter(navigation: navigation,
                                          loginFactory: loginFactory,
                                          signUpFactory: signUpFactory)
        let welcomeViewController = WelcomeViewController.instantiate()

        welcomeViewController.signUp = welcomeRouter.goToSignUp
        welcomeViewController.login = welcomeRouter.goToLogin
        navigation.setRootViewController(welcomeViewController)

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
