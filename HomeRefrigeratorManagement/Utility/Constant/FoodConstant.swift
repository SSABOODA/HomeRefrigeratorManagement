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
    
    @frozen
    enum FoodStorageType: String, CaseIterable {
        case all = "전체"
        case outdoor = "실외"
        case cold = "냉장"
        case frozen = "냉동"
    }
    
    enum FoodConstant {
        static var foodIconInfo = [
            // "채소"
            FoodModel(name: "가지", category: .vegetable),
            FoodModel(name: "감자", category: .vegetable),
            FoodModel(name: "강낭콩", category: .vegetable),
            FoodModel(name: "고구마", category: .vegetable),
            FoodModel(name: "고추", category: .vegetable),
            FoodModel(name: "깻잎", category: .vegetable),
            FoodModel(name: "당근", category: .vegetable),
            FoodModel(name: "마늘", category: .vegetable),
            FoodModel(name: "무", category: .vegetable),
            FoodModel(name: "바질", category: .vegetable),
            FoodModel(name: "밤", category: .vegetable),
            FoodModel(name: "방울토마토", category: .vegetable),
            FoodModel(name: "배추", category: .vegetable),
            FoodModel(name: "버섯", category: .vegetable),
            FoodModel(name: "부추", category: .vegetable),
            FoodModel(name: "브로콜리", category: .vegetable),
            FoodModel(name: "상추", category: .vegetable),
            FoodModel(name: "생강", category: .vegetable),
            FoodModel(name: "시금치", category: .vegetable),
            FoodModel(name: "양배추", category: .vegetable),
            FoodModel(name: "양상추", category: .vegetable),
            FoodModel(name: "아스파라거스", category: .vegetable),
            FoodModel(name: "청경채", category: .vegetable),
            FoodModel(name: "콩나물", category: .vegetable),
            FoodModel(name: "파프리카", category: .vegetable),
            FoodModel(name: "파", category: .vegetable),
            FoodModel(name: "피망", category: .vegetable),
            FoodModel(name: "호박", category: .vegetable),
            FoodModel(name: "옥수수", category: .vegetable),
            FoodModel(name: "양파", category: .vegetable),
            // "과일"
            FoodModel(name: "감", category: .fruit),
            FoodModel(name: "귤", category: .fruit),
            FoodModel(name: "레몬", category: .fruit),
            FoodModel(name: "망고", category: .fruit),
            FoodModel(name: "바나나", category: .fruit),
            FoodModel(name: "복숭아", category: .fruit),
            FoodModel(name: "배", category: .fruit),
            FoodModel(name: "블루베리", category: .fruit),
            FoodModel(name: "사과", category: .fruit),
            FoodModel(name: "석류", category: .fruit),
            FoodModel(name: "수박", category: .fruit),
            FoodModel(name: "아보카도", category: .fruit),
            FoodModel(name: "오렌지", category: .fruit),
            FoodModel(name: "체리", category: .fruit),
            FoodModel(name: "크렌베리", category: .fruit),
            FoodModel(name: "키위", category: .fruit),
            FoodModel(name: "토마토", category: .fruit),
            FoodModel(name: "파인애플", category: .fruit),
            FoodModel(name: "포도", category: .fruit),
            FoodModel(name: "딸기", category: .fruit),
            // "곡식"
            FoodModel(name: "귀리", category: .grains),
            FoodModel(name: "쌀", category: .grains),
            FoodModel(name: "곡식-직접입력", category: .grains),
            // "견과류"
            FoodModel(name: "땅콩", category: .nuts),
            FoodModel(name: "아몬드", category: .nuts),
            FoodModel(name: "잣", category: .nuts),
            FoodModel(name: "캐슈넛", category: .nuts),
            FoodModel(name: "피스타치오", category: .nuts),
            FoodModel(name: "호두", category: .nuts),
            // "육류"
            FoodModel(name: "계란", category: .meat),
            FoodModel(name: "닭고기", category: .meat),
            FoodModel(name: "돼지고기", category: .meat),
            FoodModel(name: "소고기", category: .meat),
            FoodModel(name: "양고기", category: .meat),
            FoodModel(name: "오리고기", category: .meat),
            // "수산물"
            FoodModel(name: "게", category: .seafood),
            FoodModel(name: "굴", category: .seafood),
            FoodModel(name: "문어", category: .seafood),
            FoodModel(name: "미역", category: .seafood),
            FoodModel(name: "새우", category: .seafood),
            FoodModel(name: "생선", category: .seafood),
            FoodModel(name: "오징어", category: .seafood),
            FoodModel(name: "전복", category: .seafood),
            FoodModel(name: "쭈꾸미", category: .seafood),
            FoodModel(name: "조개", category: .seafood),
            FoodModel(name: "해산물-직접입력", category: .seafood),
            // "양념"
            FoodModel(name: "조미료-직접입력", category: .seasoning),
            // "조미료"
            FoodModel(name: "소금", category: .condiment),
            FoodModel(name: "설탕", category: .condiment),
            // "소스"
            FoodModel(name: "소스-직접입력", category: .sauce),
            FoodModel(name: "간장", category: .sauce),
            FoodModel(name: "고추장", category: .sauce),
            FoodModel(name: "된장", category: .sauce),
            FoodModel(name: "마요네즈", category: .sauce),
            FoodModel(name: "케첩", category: .sauce),
            // "면류"
            FoodModel(name: "면-직접입력", category: .noodles),
            // "유제품"
            FoodModel(name: "유제품-직접입력", category: .dairyProduct),
            FoodModel(name: "생크림", category: .dairyProduct),
            FoodModel(name: "연유", category: .dairyProduct),
            FoodModel(name: "요거트", category: .dairyProduct),
            FoodModel(name: "우유", category: .dairyProduct),
            FoodModel(name: "치즈", category: .dairyProduct),
            // "음료"
            FoodModel(name: "주류-직접입력", category: .beverage),
            // "인스턴스"
            FoodModel(name: "참치캔", category: .instance),
            // "과자/제과"
            FoodModel(name: "과자", category: .snack),
            FoodModel(name: "베이글", category: .snack),
            FoodModel(name: "빵", category: .snack),
            FoodModel(name: "시리얼", category: .snack),
            FoodModel(name: "식빵", category: .snack),
            // "기타"
            FoodModel(name: "김치류", category: .etc),
            FoodModel(name: "냉동식품-직접입력", category: .etc),
            FoodModel(name: "두부", category: .etc),
            
        ]
        
    }
}

