//
//  Date+Extension.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/06.
//

import Foundation

extension Date {
    // convertDateFormat
    func convertDateFormat() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd a hh시 mm분"
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let convertNowDate = dateFormatter.string(from: nowDate)
        return convertNowDate
    }
}
