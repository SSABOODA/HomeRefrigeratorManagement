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
    
    func searchFilterData(_ query: String) {
        let query = query.trimmingCharacters(in: .whitespaces)
        
        if query.isEmpty {
            self.fetchData()
            return
        } else {
            let isChosungCheck = isChosung(word: query)
            
            foodDataList.value = foodDataList.value.filter {
                if isChosungCheck {
                    return ($0.name.contains(query) || getInitialConsonants(word: $0.name).contains(query))
                } else {
                    return $0.name.contains(query)
                }
            }
        }
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


