//
//  FoodManagementCollectionViewCell.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit
import SnapKit

class FoodManagementCollectionViewCell: BaseCollectionViewCell {
    let foodImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let nameLabel = {
        let label = UILabel()
        return label
    }()
    
    let purchaseDateLabel = {
        let label = UILabel()
        return label
    }()
    
    let expirationDateLabel = {
        let label = UILabel()
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(foodImageView)
        addSubview(nameLabel)
        addSubview(purchaseDateLabel)
        addSubview(expirationDateLabel)
    }
    
    override func configureLayout() {
        foodImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.size.equalTo(50)
        }
    }
}
