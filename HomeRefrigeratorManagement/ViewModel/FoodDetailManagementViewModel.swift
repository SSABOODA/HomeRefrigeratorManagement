//
//  FoodDetailManagementViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/08.
//

import Foundation
import RealmSwift

final class FoodDetailManagementViewModel {
    
    var food: Food?
    var isDelete = Observable(false)
    var foodModel = Observable(FoodModel(name: "", category: .etc))
    var registerDate = Observable(Date().dateFormat(date: Date()))
    
    var storageType: [String] {
        return Constant.FoodStorageType.allCases.map { $0.rawValue }
    }
    
    var completionHandler: ((Bool) -> Void)?
    
    func deleteData() {
        isDelete.value = true
        completionHandler?(isDelete.value)
    }
    
    func updateData() {
        guard let food else { return }
        
        let category = FoodCategory()
        category.categoryName = food.category?.categoryName ?? "실외"
        let storageType = StorageType()
        storageType.storageType = foodModel.value.storageType.rawValue
        
        let item = Food(value: [
            "_id": food._id,
            "name": food.name,
            "category": category,
            "storageType": storageType,
            "count": foodModel.value.count,
            "purchaseDate": foodModel.value.purchaseDate,
            "expirationDate": foodModel.value.expirationDate,
            "descriptionContent": foodModel.value.description
        ] as [String : Any])
        
        RealmTableRepository.shared.update(object: item)
    }
}

