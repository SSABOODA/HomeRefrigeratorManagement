//
//  CalendarViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/10.
//

import Foundation
import RealmSwift

class CalendarViewModel {
    
    let localRealm = RealmTableRepository.shared
    
    var foodData: Results<Food> {
        return localRealm.fetch(object: Food()).sorted(byKeyPath: "expirationDate", ascending: false)
    }
    
    
    
}
