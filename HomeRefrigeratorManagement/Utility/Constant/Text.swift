//
//  Text.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation

extension Constant {
    enum TabBarTitle {
        static let recipeVC = "recipe"
        static let foodManagementVC = "Home"
        static let settingVC = "Setting"
    }
    
    enum SystemImageName {
        static let recipeVCTabBarImage = "fork.knife.circle"
        static let foodManagementVCTabBarImage = "refrigerator"
        static let settingVCTabBarImage = "person.circle"
        
        static let recipeVCTabBarSelectImage = "\(SystemImageName.recipeVCTabBarImage).fill"
        static let foodManagementVCTabBarSelectImage = "\(SystemImageName.foodManagementVCTabBarImage).fill"
        static let settingVCTabBarSelectImage = "\(SystemImageName.settingVCTabBarImage).fill"
    }
}
