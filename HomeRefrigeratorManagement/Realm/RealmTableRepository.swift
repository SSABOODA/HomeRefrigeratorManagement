//
//  RealmTableRepository.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/27.
//

import Foundation
import RealmSwift

final class RealmTableRepository: RealmTableRepositoryType {
    
    enum TableList<T> {
        case food
        
        var table: T.Type {
            switch self {
            case .food: return Food.self as! T.Type
            }
        }
        
    }
    
    static let shared = RealmTableRepository()
    private init() {}

    let realm = try! Realm()
    
    // 현재 Schema Version Check
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    // Document file Path 확인
    @discardableResult
    func findFileURL() -> URL? {
        guard let fileURL = realm.configuration.fileURL else { return nil }
        print(fileURL)
        return fileURL
    }
    
    // realm에 저장된 데이터 확인
    func fetch() -> Results<Food> {
        let data = realm.objects(Food.self)//.sorted(byKeyPath: "date", ascending: false)
        return data
    }
    
    
}

