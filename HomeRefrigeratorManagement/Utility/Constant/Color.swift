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
        static let basePointBlueHexColor = UIColor(hexCode: "#3D6FD2") // 파란색
        static let basePointOrangeHexColor = UIColor(hexCode: "#E27749") // 주황색
    }
    
    enum collectionViewColor {
        static let collectionViewBackgroundColor = UIColor(named: "collectionViewBackgroundColor")
        static let collectionViewCellBackgroundColor = UIColor(named: "cellBackgroundColor")
    }
    
    enum TitleColor {}
    
    enum ChartColor {
        static let FoodCategoryTypeChartColor = [
            "#D3FFCE", // "채소"
            "#FFC1A1", // "과일"
            "#FFF7A1", // "곡식"
            "#D2B48C", // "견과류"
            "#FFA1B1", // "육류"
            "#A3E4FF", // "수산물"
            "#A1FFCE", // "양념"
            "#E3D7FF", // "조미료"
            "#E7FFA1", // "소스"
            "#A1FFF7", // "면류"
            "#FFFFE1", // "유제품"
            "#A1EFFF", // "음료"
            "#D0A9FF", // "인스턴스"
            "#FFD1DC", // "과자/제과"
            "#C4C4C4"  // "기타"
        ]
    }
}
