//
//  CustomTextField.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/20.
//

import UIKit

class CustomTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

