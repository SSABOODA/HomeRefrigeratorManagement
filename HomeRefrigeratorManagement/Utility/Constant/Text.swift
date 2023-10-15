//
//  Text.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation

extension Constant {
    enum TabBarTitle {
        static let calendarVC = "캘런더".localized
        static let recipeVC = "레시피".localized
        static let foodManagementVC = "관리".localized
        static let chartVC = "분석".localized
        static let settingVC = "설정".localized
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
    
    enum ImageName {
        // chartImage
        static let currentStorageCountImageName = "현재-저장-식품"
        static let successExpirationCountImageName = "유통기한-소비"
        static let failedExpirationCountImageName = "유통기한-초과"
    }
    
    
    enum NavigationTitle {
        static let calendarTitle = "캘린더".localized
        static let foodRegisterHomeTitle = "냉장고 관리".localized
        static let foodRegisterTitle = "식품 등록 방법 선택".localized
        static let foodRegisterDetailTitle = "식품 등록하기".localized
        static let foodDetailTitle = "식품 상세 정보".localized
        static let youtubeWebViewTitle = "유튜브 레시피".localized
    }
    
    enum ToastMessage {
        static let foodSaveSuccessMessage = "식품 저장이 완료되었습니다.😃".localized
        static let foodDeleteSuccessMessage = "식품이 삭제되었습니다.".localized
    }
    
    enum ButtonSetTitle {
        static let foodDeleteButtonTitle = "삭제하기".localized
        static let foodUpdateButtonTitle = "수정하기".localized
    }
    
    enum AlertText {
        // 저장 방법이 존재하지 않을 때 얼럿
        static let emptyStorageTitleMessage = "저장 방법을 선택해주세요".localized
        // 수량이 존재하지 않을 때 얼럿
        static let noInputFoodCountTitleMessage = "수량을 입력해주세요".localized
        // 식품 삭제 시
        static let deleteAlertTitleMessage = "정말 삭제하시겠습니까?".localized
        // 식품 수정 시
        static let updateAlertTitleMessage = "수정하시겠습니까?".localized
    }
    
    enum URLString {
        static let youtubeURL = "https://www.youtube.com/results?search_query"
    }
    
    enum CharViewTitle {
        static let headerSubTitle = "식품에 대한 분석을 살펴보세요".localized
        static let totalAnalysisTitle = "종합 분석".localized
        static let firstTotalAnalysisContentTitle = "현재 냉장고에 보관된 식품 수".localized
        static let secondTotalAnalysisContentTitle = "유통기한 내에 먹은 음식 수".localized
        static let thirdTotalAnalysisContentTitle = "유통기한을 지키지 못한 음식 수".localized
        static let chartAnalyTitle = "식품 유형".localized
    }
}
