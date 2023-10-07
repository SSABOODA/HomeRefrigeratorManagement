//
//  FoodStorageTypeButton.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/07.
//

import UIKit

class FoodStorageTypeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setTitleColor(Constant.BaseColor.tintColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 13)
    }
    
}
