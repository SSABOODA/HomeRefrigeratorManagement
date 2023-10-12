//
//  FoodRegisterTextFieldView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/06.
//

import UIKit

class FoodRegisterTextFieldView: UIView {
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
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
    }
    
}
