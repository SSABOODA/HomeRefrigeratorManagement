//
//  UserDefaultsHelper.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/20.
//

import Foundation

final class UserDefaultsHelper {
    static let standard = UserDefaultsHelper()
    private init() { }
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case permission
        case isManual
        case hour
        case minute
        case switchValue
    }
    
    // 푸쉬 알림
    var permission: Bool {
        get {
            return userDefaults.bool(forKey: Key.permission.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.permission.rawValue)
        }
    }
    
    var isManual: Bool {
        get {
            return userDefaults.bool(forKey: Key.isManual.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.isManual.rawValue)
        }
    }
    
    var hour: Int {
        get {
            return userDefaults.integer(forKey: Key.hour.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.hour.rawValue)
        }
    }
    
    var minute: Int {
        get {
            return userDefaults.integer(forKey: Key.minute.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.minute.rawValue)
        }
    }
    
    var switchValue: Bool {
        get {
            return userDefaults.bool(forKey: Key.switchValue.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.switchValue.rawValue)
        }
    }
}
