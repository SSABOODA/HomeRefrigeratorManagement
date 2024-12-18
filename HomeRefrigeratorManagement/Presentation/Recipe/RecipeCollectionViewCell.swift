//
//  RecipeCollectionViewCell.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/12.
//

import UIKit

class RecipeCollectionViewCell: BaseCollectionViewCell {

    
    let mainImageView = {
        let view = UIImageView()
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        return label
    }()
    
    let descLabel = {
        let label = UILabel()
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(mainImageView)
    }
    
    override func configureLayout() {
        
    }

}

