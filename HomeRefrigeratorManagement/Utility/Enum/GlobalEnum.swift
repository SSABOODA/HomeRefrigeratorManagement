//
//  FilterEnum.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/09.
//

import Foundation

enum SortType: String {
    case name = "name"
    case register = "purchaseDate"
    case expiration = "expirationDate"
}

enum FoodDataInputTextFieldTag: Int {
    case desc = 0
    case register = 1
    case expiration = 2
    case storage = 3
    case count = 4
}

