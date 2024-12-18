//
//  SceneDelegate.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let userNotification = UserNotificationRepository.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let tabBar = CustomTabBarController()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        userNotification.removePendingNotificationRequests()
        
        NotificationCenter.default.post(
            name: NSNotification.Name("permission"),
            object: nil
        )
        
        UserNotificationRepository.shared.checkPermission { _ in
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        if userNotification.checkNotificationAuthorzation() {
            if !UserDefaultsHelper.standard.isManual {
                userNotification.configureUserNotification()
            }
        }
    }
}
