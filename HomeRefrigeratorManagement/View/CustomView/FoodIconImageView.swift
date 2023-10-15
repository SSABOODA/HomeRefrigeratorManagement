//
//  FoodIconImageView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/15.
//

import UIKit

final class FoodIconImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        clipsToBounds = false
        layer.shadowColor = Constant.BaseColor.tintColor?.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
    }
}
