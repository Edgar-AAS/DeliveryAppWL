//
//  SceneDelegate.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let coordinator = AuthCoordinator()
        let navigationController = UINavigationController()
        coordinator.navigationController = navigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

