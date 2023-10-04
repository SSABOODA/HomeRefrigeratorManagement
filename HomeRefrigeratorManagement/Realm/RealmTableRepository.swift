//
//  RealmTableRepository.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/27.
//

import Foundation
import RealmSwift

final class RealmTableRepository: RealmTableRepositoryType {
    
    private let localRealm: Realm
   
    static let shared = RealmTableRepository()
    private init() {
        do {
            localRealm = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

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
    func fetch<T: Object>(object: T) -> Results<T> {
        let data = realm.objects(T.self)
        return data
    }
    
    func save<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        print(#function, "aaaa")
        do {
            try localRealm.write {
                localRealm.add(object)
                print("Realm Save Success")
            }
        }
        catch {
            errorHandler(error)
        }
    }
}

