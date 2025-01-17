//
//  FoodRegisterDetailViewModel.swift

import Foundation

class FoodRegisterListViewModel {
    
    var foodIconInfo = Observable(Constant.FoodConstant.foodIconInfo)
    var isSave = Observable(false)
    
    var completionHandler: ((Bool) -> Void)?
  
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
