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
    
    let table = Food()
    var foodData: Observable<[Food]> = Observable([Food]())
    
    var categoryList: [String] {
        return Constant.FoodCategory.allCases.map { $0.rawValue }
    }
    
    var numberOfFoodsByCategory: [Double] {
        var result = [Int]()
        for category in categoryList {
            let count = foodData.value.filter {
                return $0.category?.categoryName == category
            }.count
            result.append(count)
        }
        return result.map { Double($0) }
    }
    
    var totalFoodCount: Int {
        return RealmTableRepository.shared.fetch(object: table).count
    }
    
    func fetchData() {
        let data = RealmTableRepository.shared.fetch(object: table).toArray()
        foodData.value = data
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
    
    func makeCategoryPercetage(count: Double) -> String {
        let percentage = count/Double(self.totalFoodCount) * 100
        return percentage.isNaN ? "0%" : "\(round(percentage*10)/10)%"
    }
    
}
