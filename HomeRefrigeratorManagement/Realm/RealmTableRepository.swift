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
    
    // 현재 Schema Version Check
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    // Document file Path 확인
    @discardableResult
    func findFileURL() -> URL? {
        guard let fileURL = localRealm.configuration.fileURL else { return nil }
        print(fileURL)
        return fileURL
    }
    
    // Read Realm
    func fetch<T: Object>(object: T) -> Results<T> {
        let data = localRealm.objects(T.self)
        return data
    }
    
    // Create Realm
    func save<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
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
    
    // Update Realm
    public func update<T: Object>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        
        do {
            try localRealm.write {
                localRealm.add(object, update: .modified)
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    // Delete Realm
    public func delete<T: Object>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try localRealm.write {
                localRealm.delete(object)
            }
        }
        catch {
            errorHandler(error)
        }
    }
}

