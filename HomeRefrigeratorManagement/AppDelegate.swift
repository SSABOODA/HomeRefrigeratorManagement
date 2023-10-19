//
//  AppDelegate.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit
import FirebaseCore
import RealmSwift
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Thread.sleep(forTimeInterval: 1.0)
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkNotificationSetting),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        UserDefaultsHelper.standard.hour = 19
        UserDefaultsHelper.standard.minute = 30
        
        return true
    }
    
    
    @objc private func checkNotificationSetting() {
        UNUserNotificationCenter.current()
            .getNotificationSettings { permission in
                switch permission.authorizationStatus  {
                case .authorized:
                    print("푸시 수신 동의")
                    UserDefaultsHelper.standard.permission = true
                case .denied:
                    print("푸시 수신 거부")
                    UserDefaultsHelper.standard.permission = false
                case .notDetermined:
                    print("한 번 허용 누른 경우")
                    UserDefaultsHelper.standard.permission = true
                case .provisional:
                    print("푸시 수신 임시 중단")
                    UserDefaultsHelper.standard.permission = false
                case .ephemeral:
                    // @available(iOS 14.0, *)
                    print("푸시 설정이 App Clip에 대해서만 부분적으로 동의한 경우")
                    UserDefaultsHelper.standard.permission = true
                @unknown default:
                    print("Unknow Status")
                }
            }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

