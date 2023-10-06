//
//  FoodDetailSettingLabel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/06.
//

import UIKit

class FoodDetailSettingLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        font = .boldSystemFont(ofSize: 13)
        textAlignment = .center
    }
    
}
