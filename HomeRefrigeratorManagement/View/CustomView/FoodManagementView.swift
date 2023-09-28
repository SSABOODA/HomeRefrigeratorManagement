//
//  FoodManagementView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit
import SnapKit

class FoodManagementView: BaseView {
    
    var searchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    
    private lazy var collectionView = {
       let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(
            FoodManagementCollectionViewCell.self,
            forCellWithReuseIdentifier: FoodManagementCollectionViewCell.reuseIdentifier
        )
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
