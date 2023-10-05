//
//  FoodRegisterDetailViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/04.
//

import Foundation

class FoodRegisterListViewModel {
    
    var foodIconInfo = Observable(Constant.FoodConstant.foodIconInfo)
    
    // @deprecated
    func filterFoodInfo(with filter: String?) -> [FoodModel] {
        guard let filter else { return [] }
        let foodIconData = Constant.FoodConstant.foodIconInfo
        return filter.isEmpty ? foodIconData : foodIconData.filter { $0.name.contains(filter) }
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
}
