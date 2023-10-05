//
//  InitialConsonant.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import Foundation

let korean = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

func getInitialConsonants(word: String) -> String {
    
    var result = ""
    
    for char in word {
        let scalar = char.unicodeScalars.first!
        if scalar >= "\u{AC00}" && scalar <= "\u{D7A3}" {
            let index = Int((scalar.value - 0xAC00) / 28 / 21)
            result.append(korean[index])
        } else {
            result.append(char)
        }
    }

    return result
}


func isChosung(word: String) -> Bool {
    var isChosung = false
    for char in word {
        if 0 < korean.filter({ $0.contains(char)}).count {
            isChosung = true
        } else {
            isChosung = false
            break
        }
    }
    return isChosung
}
