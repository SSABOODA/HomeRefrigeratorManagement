//
//  AppDelegate+Extension.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/04.
//

import Foundation

extension AppDelegate {
    func addFoodCategory() {
        let foodCategory = RealmTableRepository.shared.fetch(object: FoodCategory())
        
        guard foodCategory.isEmpty else { return }
        let foodCategoryList = Constant.FoodCategory.allCases
        
        foodCategoryList.forEach { category in
            let task = FoodCategory(categoryName: category.rawValue)
            RealmTableRepository.shared.save(object: task)
        }
    
    }
}
