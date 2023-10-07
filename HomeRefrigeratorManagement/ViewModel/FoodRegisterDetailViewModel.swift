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
    var isSave = Observable(false)
    
    var completionHandler: ((Bool) -> Void)?
    
    var foodIconName: String {
        return self.foodIconInfo.value.name
    }
    
    var storageType: [String] {
        return Constant.FoodStorageType.allCases.map { $0.rawValue }
    }
    
    func saveRealmDatabase() {
        let category = FoodCategory()
        category.categoryName = foodIconInfo.value.category.rawValue
        
        let storageType = StorageType()
        storageType.storageType = foodIconInfo.value.storageType.rawValue
        
        let foodData = Food(
            name: foodIconInfo.value.name,
            count: foodIconInfo.value.count,
            purchaseDate: foodIconInfo.value.purchaseDate,
            expirationDate: foodIconInfo.value.expirationDate
        )
        foodData.category = category
        foodData.storageType = storageType
        realm.save(object: foodData)
        
        completionHandler?(isSave.value)
        
    }
}
