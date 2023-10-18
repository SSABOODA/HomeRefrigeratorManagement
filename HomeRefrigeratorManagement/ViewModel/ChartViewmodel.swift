//
//  ChartViewmodel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import Foundation
import RealmSwift

final class ChartViewmodel {
    enum TotalAnalysis {
        case totalCurrentFoodCount
        case successExpirationDate
        case failedExpirationDate
    }
    
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
    
    func totalAnalysisData(_ totalAnalysisType: TotalAnalysis) -> Int {
        self.fetchData()
        switch totalAnalysisType {
        case .totalCurrentFoodCount:
            return foodData.value.count
        case .successExpirationDate:
            return foodData.value.filter {
                ($0.expirationDate < Date()) && ($0.count == 0)
            }.count
        case .failedExpirationDate:
            return foodData.value.filter {
                $0.expirationDate < Date()
            }.count
        }
    }
    
}
