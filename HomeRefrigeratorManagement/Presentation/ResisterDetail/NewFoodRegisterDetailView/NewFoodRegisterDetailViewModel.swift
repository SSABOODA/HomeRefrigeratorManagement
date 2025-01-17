//
//  NewFoodRegisterDetailViewModel.swift

import Foundation

final class NewFoodRegisterDetailViewModel {
    let realm = RealmTableRepository.shared
    
    var foodIconInfo = Observable(FoodModel(name: "", category: .etc))
    var registerDate = Observable(Date().dateFormat(date: Date()))
    var isSave = Observable(false)
    
    var completionHandler: ((Bool) -> Void)?
    
    var foodIconName: String {
        return self.foodIconInfo.value.name
    }
    
    var storageType: [String] {
        return Constant.FoodStorageType.allCases.filter {
            $0.rawValue != "전체"
        }.map { $0.rawValue }
    }
    
    init(foodModel: FoodModel) {
        foodIconInfo.value = foodModel
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

        completionHandler?(isSave.value)
    }
}
