//
//  FoodManagementView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit
import SnapKit

class FoodManagementView: BaseView {
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
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            let size = UIScreen.main.bounds.width - 40
            layout.itemSize = CGSize(width: size/4, height: size/4)
            return layout
        }
    
}

extension FoodManagementView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodManagementCollectionViewCell.reuseIdentifier, for: indexPath) as? FoodManagementCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
