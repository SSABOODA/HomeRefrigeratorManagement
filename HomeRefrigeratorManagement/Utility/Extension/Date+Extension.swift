//
//  Date+Extension.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/06.
//

import Foundation

extension Date {
    
    enum stringDateFormatStyle: String {
        case compactDot = "yyyy.MM.dd"
        case compactUnderscore = "yyyy-MM-dd"
        case compactSlash = "yyyy/MM/dd"
        case compactKorean = "yyyy년 MM월 dd일"
        
        case dot = "yyyy.MM.dd HH:mm:ss"
        case underscore = "yyyy-MM-dd HH:mm:ss"
        case slash = "yyyy/MM/dd HH:mm:ss"
    }
    
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    func toString(format dataFormatStyle: stringDateFormatStyle) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dataFormatStyle.rawValue
        return dateFormatter.string(from: self)
    }
    
    func koreanDateFormatToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}


extension Date {
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
}
