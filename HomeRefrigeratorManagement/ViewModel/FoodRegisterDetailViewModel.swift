//
//  FoodRegisterDetailViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/04.
//

import Foundation

class FoodRegisterDetailViewModel {
    var foodIconImageName = Observable("")
    
    func numberOfItemsInSection() -> Int {
        return Constant.FoodIconInfo.foodIconImageNameCollection.count
    }
    
    func cellForItemAt(_ indexPath: IndexPath) -> String {
        return Constant.FoodIconInfo.foodIconImageNameCollection[indexPath.item]
    }
    
    
}
