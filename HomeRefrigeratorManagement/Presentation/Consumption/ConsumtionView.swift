//
//  ConsumtionView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/17.
//

import UIKit

final class ConsumtionView: BaseView {
    
    let searchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "냉장고에 저장된 식품을 검색해보세요".localized,
            attributes: [NSAttributedString.Key.font: UIFont(name: Constant.Font.pretendardBold, size: 11)!]
        )
        
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.setShowsCancelButton(true, animated: true)
        
        if let cancelButton = searchController.searchBar.value(forKey: "cancelButton") as? UIButton {
            let nsAttributedString = NSAttributedString(
                string: "취소".localized,
                attributes: [NSAttributedString.Key.font: UIFont(name: Constant.Font.pretendardBold, size: 12)!]
            )
            cancelButton.setTitleColor(Constant.BaseColor.tintColor, for: .normal)
            cancelButton.setAttributedTitle(nsAttributedString, for: .normal)
        }
        
        return searchController
    }()
    
    lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
        return collectionView
    }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension ConsumtionView {
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: size/3, height: size/3)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 15, right: 10)
        return layout
    }
}
