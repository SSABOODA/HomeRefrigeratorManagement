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
        setTitle("테스트", for: .normal)
        
        
        backgroundColor = Constant.BaseColor.backgroundColor
        layer.cornerRadius = 15
//        layer.masksToBounds = true
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        clipsToBounds = false
        
    }
    
}
