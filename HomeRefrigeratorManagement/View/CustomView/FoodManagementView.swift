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
        view.register(
            FoodManagementCollectionViewCell.self,
            forCellWithReuseIdentifier: FoodManagementCollectionViewCell.reuseIdentifier
        )
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    // TODO: Constant
    let foodRegisterButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
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
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        // tab bar height = 83.0
        foodRegisterButton.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.bottom.equalToSuperview().offset(-83-30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    
    // TODO: Constant
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let width = UIScreen.main.bounds.width - 50
        layout.itemSize = CGSize(width: width, height: 100)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        return layout
    }
    
}

extension FoodManagementView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodManagementCollectionViewCell.reuseIdentifier, for: indexPath) as? FoodManagementCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .darkGray
        return cell
    }
}
