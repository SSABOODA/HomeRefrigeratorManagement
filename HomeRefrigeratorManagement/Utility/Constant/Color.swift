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
    
    enum ChartColor {
        static let FoodCategoryTypeChartColor = [
//            "#FFAA66",  // 약한 오렌지
//            "#774499",  // 약한 바이올렛
//            "#6699AA",  // 약한 스카이 블루
//            "#333333",  // 약한 블랙
//            "#333366",  // 약한 네이비 블루
//            "#336633",  // 약한 그린
//            "#663333",  // 약한 마룬
//            "#664433",  // 약한 브라운
//            "#FF9966",  // 약한 새몬
//            "#FFCC66",  // 약한 골드
//            "#666633",  // 약한 올리브
//            "#666666",  // 약한 그레이
//            "#336666",  // 약한 시안
//            "#663366",  // 약한 퍼플
//            "#CC3333",  // 약한 레드
            "#FFA500", "#FFB732", "#FFC964", "#FFDD96", "#FFEEB8",
                "#FFF3CC", "#FFE7A7", "#FFDB82", "#FFCF5D", "#FFC341",
                "#FFB726", "#FFAB00", "#FFA100", "#FF9700", "#FF8C00"
        ]
    }
}
