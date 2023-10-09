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
    var deleteFoodData: Food?
    var isAcending = Observable(false) // false: 오름차순, true: 내림차순
    let localRealm = RealmTableRepository.shared
    
    func filterFoodData(_ query: String, _ sortType: SortType) -> Results<Food>? {
        if query.isEmpty {
            filteredFoodData = localRealm.fetch(object: Food())
        } else {
            let food = localRealm.fetch(object: Food())
            
            filteredFoodData = food.where {
                $0.name.contains(query)
            }
        }
        
        filteredFoodData = filteredFoodData?.sorted(
            byKeyPath: sortType.rawValue,
            ascending: isAcending.value
        )
        return filteredFoodData
    }
    
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
//        print("useTime: \(useTime)", "startTime: \(startTime)", "endTime: \(endTime)", "dday: \(dDay)")
        return dDay < 0 ? "D+\(-dDay)" : "D-\(dDay)"
    }
}

