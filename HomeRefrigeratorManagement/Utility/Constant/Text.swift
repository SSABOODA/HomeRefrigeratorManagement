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
        static let calendarVCTabBarImage = "calendar.badge.clock"
        static let recipeVCTabBarImage = "fork.knife"
        static let foodManagementVCTabBarImage = "refrigerator"
        static let settingVCTabBarImage = "person"
        
        // TabBar Selected System Image
        static let calendarVCTabBarSelectImage = "calendar.badge.clock"
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
        static let youtubeWebViewTitle = "유튜브 레시피"
    }
    
    enum ToastMessage {
        static let foodSaveSuccessMessage = "식품 저장이 완료되었습니다.😃"
        static let foodDeleteSuccessMessage = "식품이 삭제되었습니다."
    }
    
    enum ButtonSetTitle {
        static let foodDeleteButtonTitle = "삭제하기"
        static let foodUpdateButtonTitle = "수정하기"
    }
    
    enum AlertText {
        // 저장 방법이 존재하지 않을 때 얼럿
        static let emptyStorageTitleMessage = "저장 방법을 선택해주세요"
        // 수량이 존재하지 않을 때 얼럿
        static let noInputFoodCountTitleMessage = "수량을 입력해주세요"
        // 식품 삭제 시
        static let deleteAlertTitleMessage = "정말 삭제하시겠습니까?"
        // 식품 수정 시
        static let updateAlertTitleMessage = "수정하시겠습니까?"
    }
    
    enum URLString {
        static let youtubeURL = "https://www.youtube.com/results?search_query"
    }
}
