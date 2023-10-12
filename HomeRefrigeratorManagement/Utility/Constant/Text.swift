//
//  Text.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation

extension Constant {
    enum TabBarTitle {
        static let calendarVC = "캘런더"
        static let recipeVC = "레시피"
        static let foodManagementVC = "관리"
        static let settingVC = "My"
    }
    
    enum SystemImageName {
        
        // TabBar System Image
        static let calendarVCTabBarImage = "calendar.circle"
        static let recipeVCTabBarImage = "fork.knife"
        static let foodManagementVCTabBarImage = "refrigerator"
        static let settingVCTabBarImage = "person.circle"
        
        // TabBar Selected System Image
        static let calendarVCTabBarSelectImage = "\(SystemImageName.calendarVCTabBarImage).fill"
        static let recipeVCTabBarSelectImage = "fork.knife"
        static let foodManagementVCTabBarSelectImage = "\(SystemImageName.foodManagementVCTabBarImage).fill"
        static let settingVCTabBarSelectImage = "\(SystemImageName.settingVCTabBarImage).fill"
        
        // FoodRegisterDetail
        static let foodRegisterDetailSaveButtonImage = "checkmark"
    }
    
    
    enum NavigationTitle {
        static let foodRegisterHomeTitle = "냉장고 관리"
        static let foodRegisterTitle = "식품 등록 방법 선택"
        static let foodRegisterDetailTitle = "식품 등록하기"
        static let foodDetailTitle = "식품 상세 정보"
    }
    
    enum ToastMessage {
        static let foodSaveSuccessMessage = "식품 저장이 완료되었습니다.😃"
    }
}
