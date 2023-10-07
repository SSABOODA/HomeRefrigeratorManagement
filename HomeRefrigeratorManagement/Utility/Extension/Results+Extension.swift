//
//  Results+Extension.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/08.
//

import Foundation
import RealmSwift

extension Results {
  func toArray() -> [Element] {
    return compactMap {
        $0
    }
  }
}
