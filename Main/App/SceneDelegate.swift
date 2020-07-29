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

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let navigation = NavigationController()
        let httpClient = makeAlamofireAdapter()
        let addAccount = makeAddAccount(httpClient: httpClient)
        let signUpController = makeSignUpViewController(addAccount: addAccount)
        navigation.setRootViewController(signUpController)

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
