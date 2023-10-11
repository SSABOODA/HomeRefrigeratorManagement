//
//  Color.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

extension Constant {
    enum BaseColor {
        static let backgroundColor = UIColor(named: "backgroundColor")
        static let grayContrastBackgroundColor = UIColor(named: "grayContrastBackgroundColor")
        static let tintColor = UIColor(named: "tintColor")
        static let borderColor = UIColor.lightGray.cgColor
        static let basePointColor = UIColor(hexCode: "#3D6FD2") // 파란색
    }
    
    enum collectionViewColor {
        static let collectionViewBackgroundColor = UIColor(named: "collectionViewBackgroundColor")
        static let collectionViewCellBackgroundColor = UIColor(named: "cellBackgroundColor")
    }
    
    enum TitleColor {}
}
