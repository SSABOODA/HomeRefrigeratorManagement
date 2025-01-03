//
//  FoodIconCollectionViewCell.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/04.
//

import UIKit
import SnapKit

class FoodIconCollectionViewCell: BaseCollectionViewCell {
    
    lazy var foodIconImageView = {
        let view = UIImageView()
        view.clipsToBounds = false
        view.layer.shadowColor = Constant.BaseColor.tintColor?.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let foodIconNameLabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont(name: Constant.Font.pretendardBold, size: 13)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(foodIconImageView)
        addSubview(foodIconNameLabel)
    }
    
    override func configureLayout() {
        foodIconImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.center.equalToSuperview()
        }
        
        foodIconNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(foodIconImageView.snp.centerX)
            make.top.equalTo(foodIconImageView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}
