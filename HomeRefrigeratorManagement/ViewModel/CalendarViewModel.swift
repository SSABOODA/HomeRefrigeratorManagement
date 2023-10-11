//
//  CalendarViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/10.
//

import Foundation
import RealmSwift

final class CalendarViewModel {
    
    let localRealm = RealmTableRepository.shared
    
    var filteredFoodData: Observable<[Food]> = Observable([])
    
    var foodData: Results<Food> {
        return localRealm.fetch(object: Food()).sorted(byKeyPath: "expirationDate", ascending: false)
    }
    
    func fetchImminentExpirationDateFoodData(_ selectedDate: Date) {
        filteredFoodData.value.removeAll()
        let selectedStringDate = selectedDate.toString(format: .compactDot)
        for item in foodData {
            let itemStringDate = item.expirationDate.toString(format: .compactDot)
            if itemStringDate == selectedStringDate {
                filteredFoodData.value.append(item)
            }
        }
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
