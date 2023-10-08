//
//  FoodDetailManagementViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/08.
//

import Foundation
import RealmSwift

class FoodDetailManagementViewModel {
    
    var food: Food?
    var isDelete = Observable(false)
    
    var completionHandler: ((Bool) -> Void)?
    
    func deleteData() {
        isDelete.value = true
        completionHandler?(isDelete.value)
    }
}

