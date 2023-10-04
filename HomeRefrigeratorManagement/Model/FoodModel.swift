//
//  Food.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/04.
//

import Foundation

struct FoodModel: Hashable {
    
    enum category: String {
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
    
    let identifier = UUID()
    var name: String
    var category: FoodModel.category
}



