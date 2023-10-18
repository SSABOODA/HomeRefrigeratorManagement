//
//  FoodManagementViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation
import RealmSwift

final class FoodManagementViewModel {
    
    var filteredFoodData: Results<Food>?
    var filteredFoodDataArray: [Food]?
    
    var deleteFoodData: Food?
    var isAcending = Observable(false) // false: 오름차순, true: 내림차순
    let localRealm = RealmTableRepository.shared
    
    func filterFoodData(
        query: String,
        sortType: SortType,
        storageType: Constant.FoodStorageType
    ) -> [Food]? {
        let food = localRealm.fetch(object: Food())
        var foodItemInfo = [Food]()
        
        if query.isEmpty {
            filteredFoodData = food
        } else {
            filteredFoodData = food.where {
                $0.name.contains(query)
            }
            
            for item in food {
                if getInitialConsonants(word: item.name).contains(query) || item.name.contains(query) {
                    foodItemInfo.append(item)
                }
            }
        }
        
        // 저장 방법 필터
        self.filterStorageType(storageType)
        
        // 식품 정렬
        filteredFoodData = filteredFoodData?.sorted(
            byKeyPath: sortType.rawValue,
            ascending: isAcending.value
        )
        
        // 검색어 있을 경우
        if !foodItemInfo.isEmpty {
            filteredFoodDataArray = foodItemInfo
            return filteredFoodDataArray
        }
        
        filteredFoodDataArray = filteredFoodData?.toArray()
        return filteredFoodData?.toArray()
    }

    func filterStorageType(_ storageType: Constant.FoodStorageType) {        
        if storageType != .all {
            filteredFoodData = filteredFoodData?.where({ food in
                return food.storageType.storageType == storageType.rawValue
            })
        }
    }
}

extension FoodManagementViewModel {
    func filterInitialConsonant(with searchText: String) -> [FoodModel] {
        let foodIconData = Constant.FoodConstant.foodIconInfo
        if searchText.isEmpty {
            return foodIconData
        }
        
        let text = searchText.trimmingCharacters(in: .whitespaces)
        let isChosungCheck = isChosung(word: text)

        let filterText = foodIconData.filter({
            if isChosungCheck {
                return ($0.name.contains(text) || getInitialConsonants(word: $0.name).contains(text))
            } else {
                return $0.name.contains(text)
            }
        })
        return filterText
    }
    
    func caculateDday(_ expirationData: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        guard let startTime = format.date(from: format.string(from: Date())) else { return "0" }
        guard let endTime = format.date(from: format.string(from: expirationData)) else { return "0" }
        let useTime = Int(endTime.timeIntervalSince(startTime))
        let dDay = Int(floor(Double(useTime/86400)))
        return dDay < 0 ? "D+\(-dDay)" : "D-\(dDay)"
    }
}
