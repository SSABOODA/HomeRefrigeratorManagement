//
//  ConsumptionViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/17.
//

import UIKit
import RealmSwift

final class ConsumptionViewModel {
    
    static let shared = ConsumptionViewModel()
    private init() {}
    
    let localRealm = RealmTableRepository.shared
    var foodDataList = Observable([Food]())
    
    func fetchData() {
        foodDataList.value = RealmTableRepository.shared.fetch(object: Food()).toArray()
    }
    
    func testUpdate() {
        self.updateCount(indexPath: 0, updatedCount: 789)
    }
    
    func updateCount(indexPath: Int, updatedCount: Int) {
        let foodData = foodDataList.value[indexPath]

        let category = FoodCategory()
        guard let datacategory = foodData.category else { return }
        category.categoryName = datacategory.categoryName
        
        let storageType = StorageType()
        guard let dataStorageType = foodData.storageType else { return }
        storageType.storageType = dataStorageType.storageType

        let item = Food(value: [
            "_id": foodData._id,
            "name": foodData.name,
            "category": category,
            "storageType": storageType,
            "count": updatedCount,
            "purchaseDate": foodData.purchaseDate,
            "expirationDate": foodData.expirationDate,
            "descriptionContent": foodData.descriptionContent
        ] as [String : Any])

        localRealm.update(object: item)
        
    }
}


/*
 func updateData() {
     guard let food else { return }
     
     let category = FoodCategory()
     category.categoryName = food.category?.categoryName ?? "기타"
     let storageType = StorageType()
     storageType.storageType = foodModel.value.storageType.rawValue
     
     let item = Food(value: [
         "_id": food._id,
         "name": food.name,
         "category": category,
         "storageType": storageType,
         "count": foodModel.value.count == 0 ? food.count : foodModel.value.count,
         "purchaseDate": foodModel.value.purchaseDate,
         "expirationDate": foodModel.value.expirationDate,
         "descriptionContent": foodModel.value.description.isEmpty ? food.descriptionContent : foodModel.value.description
     ] as [String : Any])
     
     localRealm.update(object: item)
 }
 */
