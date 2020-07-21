//
//  SceneDelegate.swift
//  Main
//
//  Created by Felipe Ribeiro Mendes on 21/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let signUpComposer = SignUpComposer.composerViewController(addAccount: RemoteUseCaseFactory.makeAddAccount())
        window?.rootViewController = signUpComposer
        window?.makeKeyAndVisible()
    }
}
