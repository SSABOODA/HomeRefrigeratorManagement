//
//  FoodRegisterButton.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/29.
//

import UIKit

class FoodRegisterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}
