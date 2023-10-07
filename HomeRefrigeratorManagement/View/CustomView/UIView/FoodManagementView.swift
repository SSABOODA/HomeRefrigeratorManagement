//
//  FoodManagementView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit
import SnapKit

class FoodManagementView: BaseView {
    
    let searchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        return view
    }()
    
    // TODO: Constant
    let foodRegisterButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constant.BaseColor.baseColor
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        foodRegisterButton.layer.cornerRadius = foodRegisterButton.frame.width / 2
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(foodRegisterButton)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        // tab bar height = 83.0
        foodRegisterButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.bottom.equalToSuperview().offset(-83-30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
    
    // TODO: Constant
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 30
        let width = UIScreen.main.bounds.width - 50
        layout.itemSize = CGSize(width: width, height: 100)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        return layout
    }
}

