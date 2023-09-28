//
//  RealmTableRepositoryProtocol.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import Foundation

protocol RealmTableRepositoryType: AnyObject {
    func checkSchemaVersion()
    func findFileURL() -> URL?
//    func fetch() -> Results<ProductTable>
//    func fetchFilter() -> Results<ProductTable>
//    func createItem(_ item: ProductTable)
//    func updateItem(updateValue: [String: Any])
//    func deleteItem(_ item: ProductTable)
}
