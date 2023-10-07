//
//  FoodManagementViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation
import RealmSwift

final class FoodManagementViewModel {
    var realmFoodData: Results<Food>?
    
    func settingRealmFoodData() {
        realmFoodData = RealmTableRepository.shared.fetch(object: Food())
    }
}

