//
//  Text.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation

extension Constant {
    enum TabBarTitle {
        static let recipeVC = "Recipe"
        static let foodManagementVC = "Home"
        static let settingVC = "My"
    }
    
    enum SystemImageName {
        
        // TabBar System Image
        static let recipeVCTabBarImage = "fork.knife.circle"
        static let foodManagementVCTabBarImage = "refrigerator"
        static let settingVCTabBarImage = "person.circle"
        
        // TabBar Selected System Image
        static let recipeVCTabBarSelectImage = "\(SystemImageName.recipeVCTabBarImage).fill"
        static let foodManagementVCTabBarSelectImage = "\(SystemImageName.foodManagementVCTabBarImage).fill"
        static let settingVCTabBarSelectImage = "\(SystemImageName.settingVCTabBarImage).fill"
        
        //
        static let foodRegisterDetailSaveButtonImage = "checkmark"
        
    }
    
    enum ButtonTitle {
        static let foodDirectRegister = "직접 등록하기"
        static let foodCameraRegister = "카메라로 등록하기"
    }
    
    enum NavigationTitle {
        static let foodRegisterTitle = "식품 등록 방법 선택"
        static let foodRegisterDetailTitle = "식품 등록하기"
    }
}
