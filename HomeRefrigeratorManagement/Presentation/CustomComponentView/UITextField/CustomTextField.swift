//
//  CustomTextField.swift

import UIKit

final class CustomTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

