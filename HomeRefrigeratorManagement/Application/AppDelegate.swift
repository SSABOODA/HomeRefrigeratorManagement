//
//  AppDelegate.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import RealmSwift
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Thread.sleep(forTimeInterval: 1.0)
        // Firebase
        FirebaseApp.configure()
        
        // RealmTableRepository
        RealmTableRepository.shared.findFileURL()
        
        // IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        
        // UNUserNotificationCenter
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            print(success, error)
        }
        
        if !UserDefaultsHelper.standard.isManual {
            UserDefaultsHelper.standard.hour = 19
            UserDefaultsHelper.standard.minute = 30
        }
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        // FirebaseMessaging
        Messaging.messaging().delegate = self
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, 
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, 
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, 
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("apple token: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }
}


extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, 
                   didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
