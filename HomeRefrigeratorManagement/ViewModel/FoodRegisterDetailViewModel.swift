//
//  FoodRegisterDetailViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import Foundation

class FoodRegisterDetailViewModel {
    
    var foodIconInfo = Observable(FoodModel(name: "", category: .etc))
    var registerDate = Observable(Date().dateFormat(date: Date()))
    
    
    
    var foodIconName: String {
        return self.foodIconInfo.value.name
    }
    
    
    
    
}
