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
        
        // FoodRegisterDetail
        static let foodRegisterDetailSaveButtonImage = "checkmark"
    }
    
    enum FoodIconInfo {
        static let foodIconInfo = [
            FoodModel(name: "가지", category: .vegetable)
        ]
        static let foodIconImageNameCollection = [
            "가지", "간장", "감", "감자", "강낭콩", "게", "계란", "고구마", "고추", "고추장",
            "과자", "굴", "귀리", "귤", "깻잎", "닭고기", "당근", "돼지고기", "된장", "땅콩",
            "레몬", "마늘", "마요네즈", "망고", "멜론", "면-직접입력", "무", "문어", "미역",
            "바나나", "바질", "밤", "방울토마토", "배", "배추","버섯", "베이글", "복숭아",
            "부추", "브로콜리", "블루베리", "빵", "사과", "상추", "새우", "생강", "생선",
            "생크림", "석류", "설탕", "소고기", "소금", "소스-직접입력", "수박", "시금치", "시리얼",
            "식빵", "쌀", "아몬드", "아보카도", "아스파라거스", "양고기", "양배추", "양상추",
            "연유", "오렌지", "오리고기", "오징어", "요거트", "우유", "유제품-직접입력", "잣", "전복",
            "조개", "조미료-직접입력", "주류-직접입력", "쭈꾸미", "참치캔", "청경채", "체리", "치즈",
            "캐슈넛", "케첩", "콩나물", "크렌베리", "키위", "토마토", "파", "파인애플", "파프리카",
            "포도", "피망", "피스타치오", "해산물-직접입력", "호두", "호박","옥수수"
        ]
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
