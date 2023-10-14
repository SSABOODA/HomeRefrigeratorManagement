//
//  ChartViewmodel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import Foundation
import RealmSwift

final class ChartViewmodel {
    var foodData: Observable<[Food]> = Observable([Food]())
    
    func fetchData() {
        let table = Food()
        let data = RealmTableRepository.shared.fetch(object: table).toArray()
        foodData.value = data
    }
    
    func makeFoodCategoryList() -> [String] {
        return Constant.FoodCategory.allCases.map { $0.rawValue }
    }
    
    func numberOfFoodsByCategory(_ categoryList: [String]) -> [Double] {
        var result = [Int]()
        for category in categoryList {
            let count = foodData.value.filter {
                return $0.category?.categoryName == category
            }.count
            result.append(count)
        }
        return result.map { Double($0) }
    }
    
}
