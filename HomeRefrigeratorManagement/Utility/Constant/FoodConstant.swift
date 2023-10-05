//
//  FoodConstantInfo.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/04.
//

import Foundation

extension Constant {
    
    enum FoodCategory: String, CaseIterable {
        case vegetable = "채소"
        case fruit = "과일"
        case grains = "곡식"
        case nuts = "견과류"
        case meat = "육류"
        case seafood = "수산물"
        case seasoning = "양념"
        case condiment = "조미료"
        case sauce = "소스"
        case noodles = "면류"
        case dairyProduct = "유제품"
        case beverage = "음료"
        case instance = "인스턴스"
        case snack = "과자/제과"
        case etc = "기타"
        // 김치/젓갈
    }
    
    enum FoodConstant {
        static var foodIconInfo = [
            // "채소"
            FoodModel(name: "가지", category: .vegetable),
            FoodModel(name: "감자", category: .vegetable),
            FoodModel(name: "강낭콩", category: .vegetable),
            FoodModel(name: "고구마", category: .vegetable),
            FoodModel(name: "고추", category: .vegetable),
            FoodModel(name: "깻잎", category: .vegetable),
            FoodModel(name: "당근", category: .vegetable),
            FoodModel(name: "마늘", category: .vegetable),
            FoodModel(name: "무", category: .vegetable),
            FoodModel(name: "바질", category: .vegetable),
            FoodModel(name: "밤", category: .vegetable),
            FoodModel(name: "방울토마토", category: .vegetable),
            FoodModel(name: "배추", category: .vegetable),
            FoodModel(name: "버섯", category: .vegetable),
            FoodModel(name: "부추", category: .vegetable),
            FoodModel(name: "브로콜리", category: .vegetable),
            FoodModel(name: "상추", category: .vegetable),
            FoodModel(name: "생강", category: .vegetable),
            FoodModel(name: "시금치", category: .vegetable),
            // "과일"
            FoodModel(name: "감", category: .fruit),
            FoodModel(name: "귤", category: .fruit),
            FoodModel(name: "레몬", category: .fruit),
            FoodModel(name: "망고", category: .fruit),
            FoodModel(name: "바나나", category: .fruit),
            FoodModel(name: "복숭아", category: .fruit),
            FoodModel(name: "배", category: .fruit),
            FoodModel(name: "블루베리", category: .fruit),
            FoodModel(name: "사과", category: .fruit),
            FoodModel(name: "석류", category: .fruit),
            FoodModel(name: "수박", category: .fruit),
            // "곡식"
            FoodModel(name: "귀리", category: .grains),
            // "견과류"
            FoodModel(name: "땅콩", category: .nuts),
            // "육류"
            FoodModel(name: "계란", category: .meat),
            FoodModel(name: "닭고기", category: .meat),
            FoodModel(name: "돼지고기", category: .meat),
            FoodModel(name: "소고기", category: .meat),
            // "수산물"
            FoodModel(name: "게", category: .seafood),
            FoodModel(name: "굴", category: .seafood),
            FoodModel(name: "문어", category: .seafood),
            FoodModel(name: "미역", category: .seafood),
            FoodModel(name: "새우", category: .seafood),
            FoodModel(name: "생선", category: .seafood),
            // "양념"
            // "조미료"
            FoodModel(name: "소금", category: .condiment),
            FoodModel(name: "설탕", category: .condiment),
            // "소스"
            FoodModel(name: "간장", category: .sauce),
            FoodModel(name: "고추장", category: .sauce),
            FoodModel(name: "된장", category: .sauce),
            FoodModel(name: "마요네즈", category: .sauce),
            FoodModel(name: "소스-직접입력", category: .sauce),
            // "면류"
            FoodModel(name: "면-직접입력", category: .noodles),
            // "유제품"
            FoodModel(name: "생크림", category: .dairyProduct),
            // "음료"
            // "인스턴스"
            // "과자/제과"
            FoodModel(name: "과자", category: .snack),
            FoodModel(name: "베이글", category: .snack),
            FoodModel(name: "빵", category: .snack),
            FoodModel(name: "시리얼", category: .snack),
            // "기타"
            
        ]
        
        static let foodIconImageNameCollection = [
            "가지", "간장", "감", "감자", "강낭콩", "게", "계란", "고구마", "고추", "고추장",
            "과자", "굴", "귀리", "귤", "깻잎", "닭고기", "당근", "돼지고기", "된장", "땅콩",
            "레몬", "마늘", "마요네즈", "망고", "멜론", "면-직접입력", "무", "문어", "미역",
            "바나나", "바질", "밤", "방울토마토", "배", "배추","버섯", "베이글", "복숭아",
            //
            "부추", "브로콜리", "블루베리", "빵", "사과", "상추", "새우", "생강", "생선",
            "생크림", "석류", "설탕", "소고기", "소금", "소스-직접입력", "수박", "시금치", "시리얼",
            "식빵", "쌀", "아몬드", "아보카도", "아스파라거스", "양고기", "양배추", "양상추",
            "연유", "오렌지", "오리고기", "오징어", "요거트", "우유", "유제품-직접입력", "잣", "전복",
            "조개", "조미료-직접입력", "주류-직접입력", "쭈꾸미", "참치캔", "청경채", "체리", "치즈",
            "캐슈넛", "케첩", "콩나물", "크렌베리", "키위", "토마토", "파", "파인애플", "파프리카",
            "포도", "피망", "피스타치오", "해산물-직접입력", "호두", "호박","옥수수"
        ]
    }
}

