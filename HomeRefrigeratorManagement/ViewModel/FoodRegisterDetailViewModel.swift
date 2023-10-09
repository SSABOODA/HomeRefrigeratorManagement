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
        let data = foodIconInfo.value
        
        let category = FoodCategory()
        category.categoryName = data.category.rawValue
        
        let storageType = StorageType()
        storageType.storageType = data.storageType.rawValue
        
        let foodData = Food(
            name: data.name,
            count: data.count,
            purchaseDate: data.purchaseDate,
            expirationDate: data.expirationDate,
            descriptionContent: data.description
        )
        foodData.category = category
        foodData.storageType = storageType
        realm.save(object: foodData)
        
        
        for i in data.name.unicodeScalars {
            print(i, i.value)
        }
        print("==========================")
        for j in "브로콜리".unicodeScalars {
            print(j, j.value)
        }
        
        for j in "가지".unicodeScalars {
            print(j, j.value)
        }
        
        print("=========================123")
        
        
        completionHandler?(isSave.value)
    }
}
