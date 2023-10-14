//
//  CharContentView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import UIKit

final class ChartContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Constant.BaseColor.backgroundColor
        layer.cornerRadius = 10
        clipsToBounds = true
        clipsToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
    }
    
    
}
