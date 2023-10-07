//
//  FoodRegisterDetailViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import Foundation

class FoodRegisterDetailViewModel {
    
    let realm = RealmTableRepository.shared
    
    var foodIconInfo = Observable(FoodModel(name: "", category: .etc))
    var registerDate = Observable(Date().dateFormat(date: Date()))
    
    var foodIconName: String {
        return self.foodIconInfo.value.name
    }
    
    func saveRealmDatabase() {
        let category = FoodCategory()
        category.categoryName = foodIconInfo.value.category.rawValue
        let foodData = Food(
            name: foodIconInfo.value.name,
            count: foodIconInfo.value.count,
            purchaseDate: foodIconInfo.value.purchaseDate,
            expirationDate: foodIconInfo.value.expirationDate
        )
        foodData.category = category
        realm.save(object: foodData)
    }
}
