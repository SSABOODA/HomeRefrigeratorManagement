//
//  UserNotificationRepository.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/20.
//

import UIKit

final class UserNotificationRepository {
    static let shared = UserNotificationRepository()
    private init() {}
    
    func removePendingNotificationRequests() {
        print(#function)
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func checkNotificationAuthorzation() -> Bool {
        return UserDefaultsHelper.standard.permission
    }
    
    func checkPermission(_ completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .getNotificationSettings { [weak self] permission in
                switch permission.authorizationStatus  {
                case .authorized:
                    print("푸시 수신 동의")
                    UserDefaultsHelper.standard.permission = true
                case .denied:
                    print("푸시 수신 거부")
                    UserDefaultsHelper.standard.permission = false
                case .notDetermined:
                    print("한 번 허용 누른 경우")
                    UserDefaultsHelper.standard.permission = false
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
                completion(UserDefaultsHelper.standard.permission)
            }
    }
    
    func calculateImminentFood(_ baseDate: Int) -> Int? {
        var dayComponent = DateComponents()
        dayComponent.day = -baseDate
        let theCalendar = Calendar.current
        let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())
        guard let nextDate else { return nil }
        
        let food = RealmTableRepository.shared.fetch(
            object: Food()
        ).sorted(
            byKeyPath: "expirationDate",
            ascending: false
        ).toArray().filter {
            return $0.expirationDate >= nextDate
        }
        return food.count
    }
    
    func configureUserNotification() {
        print(#function)
        let content = UNMutableNotificationContent()
        guard let count = self.calculateImminentFood(3) else { return }
        guard count != 0 else { return }
        
        content.title = "유통기한이 임박한 상품이 \(count)개 있어요"
        content.body = "식품을 소비하거나 관리해보세요:)"
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        var component = DateComponents()
        component.hour = UserDefaultsHelper.standard.hour
        component.minute = UserDefaultsHelper.standard.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
//            print(error?.localizedDescription)
        }
    }
    
    
}
