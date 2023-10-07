//
//  Food.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/04.
//

import Foundation

struct FoodModel: Hashable {
    let identifier = UUID()
    var name: String
    var category: Constant.FoodCategory
    var storageType: Constant.FoodStorageType = .outdoor
    var count: Int = 0
    var purchaseDate: Date = Date()
    var expirationDate: Date = Date()
    var description: String = ""
    
}



