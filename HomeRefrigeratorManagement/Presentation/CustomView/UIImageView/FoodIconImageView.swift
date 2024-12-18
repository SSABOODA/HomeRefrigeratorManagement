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
    }
}
