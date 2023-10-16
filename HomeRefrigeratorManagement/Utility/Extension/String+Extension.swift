//
//  Extension+String.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import Foundation
import UIKit

// localized
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
    
    
}

// string to date
extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}


// html to string
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding:String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


// NSAttributedString
extension String {
    func makeNSAttributedString(fontName: String, fontSize: CGFloat) -> NSAttributedString {
        let nsAttributedString = NSAttributedString(
            string: self.localized,
            attributes: [NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize)!]
        )
        return nsAttributedString
    }
}
