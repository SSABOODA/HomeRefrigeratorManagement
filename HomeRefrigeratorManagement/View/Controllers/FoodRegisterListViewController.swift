//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/29.
//

import UIKit

class FoodRegisterListViewController: BaseViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    let searchBar = UISearchBar()

    lazy var collectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout()
        )
        view.delegate = self
        return view
    }()
    
    let viewModel = FoodRegisterListViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, FoodModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FoodRegisterDetailViewController", #function)
        
        configureDataSource()
        setupSearchBar()
        performQuery(with: "")
    }
    
    override func configureView() {
//        title = Constant.NavigationTitle.foodRegisterDetailTitle
        view.backgroundColor = Constant.BaseColor.backgroundColor
        self.navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        searchBar.delegate = self
        
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = ""
        backBarBtnItem.tintColor = Constant.BaseColor.tintColor
        navigationItem.backBarButtonItem = backBarBtnItem
        
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
extension FoodRegisterListViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FoodIconCollectionViewCell,FoodModel> { cell, indexPath, itemIdentifier in
            
            cell.foodIconImageView.image = UIImage(named: itemIdentifier.name)
            cell.foodIconNameLabel.text = itemIdentifier.name
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    private func performQuery(with filter: String?) {
        viewModel.foodIconInfo.value = viewModel.filterInitialConsonant(with: filter ?? "")
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, FoodModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.foodIconInfo.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FoodRegisterListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
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
extension FoodRegisterListViewController {
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

extension FoodRegisterListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        sheetPresentationController?.animateChanges {
            sheetPresentationController?.selectedDetentIdentifier = .large
        }
        
        let nextVC = FoodRegisterDetailViewController()
        nextVC.viewModel.foodIconInfo.value = self.viewModel.foodIconInfo.value[indexPath.item]
        transition(viewController: nextVC, style: .push)
    
    }
}
