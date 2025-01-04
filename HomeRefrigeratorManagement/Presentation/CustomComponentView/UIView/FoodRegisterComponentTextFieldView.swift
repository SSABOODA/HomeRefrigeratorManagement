//
//  FoodRegisterComponentTextFieldView.swift

import UIKit

class FoodRegisterComponentTextFieldView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = false
    }    
}
