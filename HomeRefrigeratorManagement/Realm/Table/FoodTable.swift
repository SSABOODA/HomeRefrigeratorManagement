//
//  FoodTable.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/27.
//

import Foundation
import RealmSwift

// Refrigerator Table
class Refrigerator: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

// Food Table
class Food: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var count: Int
    @Persisted var purchaseDate: Date
    @Persisted var expirationDate: Date
    @Persisted var category: FoodCategory?
    @Persisted var storageType: StorageType?
    // FK 냉장고 Id
    
    convenience init(name: String, count: Int, purchaseDate: Date, expirationDate: Date) {
        self.init()
        self.name = name
        self.count = count
        self.purchaseDate = purchaseDate
        self.expirationDate = expirationDate
    }
}

// MARK: - EmbeddedObject

// Food Category Table
class FoodCategory: EmbeddedObject {
    @Persisted var categoryName: String
}

// Storage Type Table
class StorageType: EmbeddedObject {
    @Persisted var storageType: String
}






