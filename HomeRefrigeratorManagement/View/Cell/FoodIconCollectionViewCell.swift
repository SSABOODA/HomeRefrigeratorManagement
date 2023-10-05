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
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    let foodIconNameLabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .boldSystemFont(ofSize: 13)
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
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}
