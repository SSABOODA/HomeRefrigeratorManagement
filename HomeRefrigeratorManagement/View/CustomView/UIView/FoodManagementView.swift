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
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "냉장고에 저장된 식품을 검색해보세요".localized
        return searchController
    }()
    
    lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.register(
            FoodManagementCollectionViewHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FoodManagementCollectionViewHeaderView.description()
        )
        return collectionView
    }()
    
    // TODO: Constant
    let foodRegisterButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constant.BaseColor.basePointColor
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
//    private func collectionViewLayout() -> UICollectionViewFlowLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 15
//        layout.minimumInteritemSpacing = 30
//        let width = Constant.ScreenSize.deviceScreenWidth - 40
//        layout.itemSize = CGSize(width: width, height: 100)
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 25, right: 0)
//        return layout
//    }
    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

//            let groupFractionalWidth = CGFloat(
//                layoutEnvironment.container.effectiveContentSize.width > 500 ? 0.425 : 0.85
//            )
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

            let titleSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(Constant.ScreenSize.deviceScreenHeight*0.1)
            )
            
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: FoodManagementViewController.description(),
                alignment: .top
            )
            titleSupplementary.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10

        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider,
            configuration: config
        )
        
        return layout
    }
}

