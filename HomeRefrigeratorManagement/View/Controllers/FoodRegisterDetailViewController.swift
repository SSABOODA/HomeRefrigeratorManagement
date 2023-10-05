//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/29.
//

import UIKit

class FoodRegisterDetailViewController: BaseViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    let searchBar = UISearchBar()

    lazy var collectionView = {
       let view = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
       )
        return view
    }()
    
    let viewModel = FoodRegisterDetailViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, FoodModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FoodRegisterDetailViewController", #function)
        
        configureDataSource()
        setupSearchBar()
        performQuery(with: "")
    }
    
    override func configureView() {
        title = Constant.NavigationTitle.foodRegisterDetailTitle
        view.backgroundColor = Constant.BaseColor.backgroundColor
        self.navigationItem.titleView = searchBar
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: Constant.SystemImageName.foodRegisterDetailSaveButtonImage),
//            style: .plain,
//            target: self,
//            action: #selector(checkmarkButtonCliecd)
//        )
    
        view.addSubview(collectionView)
        searchBar.delegate = self
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func checkmarkButtonCliecd() {
        print(#function)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "식품을 검색해보세요"
        searchBar.showsCancelButton = true
    }

}

// MARK: - DataSource
extension FoodRegisterDetailViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FoodIconCollectionViewCell,FoodModel> { cell, indexPath, itemIdentifier in
            
            cell.foodIconImageView.image = UIImage(named: itemIdentifier.name)
            cell.foodIconNameLabel.text = itemIdentifier.name
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    func performQuery(with filter: String?) {
        let foodList = filterFoodInfo(with: filter)
        var snapshot = NSDiffableDataSourceSnapshot<Section, FoodModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(foodList)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func filterFoodInfo(with filter: String?) -> [FoodModel] {
        guard let filter else { return [] }
        
        if filter.isEmpty {
            return Constant.FoodConstant.foodIconInfo
        } else {
            return Constant.FoodConstant.foodIconInfo.filter { $0.name.contains(filter) }
        }
    }
}

extension FoodRegisterDetailViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        performQuery(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        performQuery(with: searchBar.text)
    }
}

// MARK: - UICollectionViewFlowLayout
extension FoodRegisterDetailViewController {
    // TODO: Constant
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let spacing: CGFloat = 8
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        let size = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: size/4, height: size/4)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }
}
