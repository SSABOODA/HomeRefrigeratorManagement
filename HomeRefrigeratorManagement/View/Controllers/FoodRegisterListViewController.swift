//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/29.
//

import UIKit

final class FoodRegisterListViewController: BaseViewController {
    
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
        print("FoodRegisterListViewController", #function)
        
        configureDataSource()
        setupSearchBar()
        performQuery(with: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("FoodRegisterListViewController", #function)
        viewModel.completionHandler?(viewModel.isSave.value)
    }
    
    override func configureView() {
        view.backgroundColor = Constant.BaseColor.backgroundColor
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupSearchBar() {
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "저장할 식품을 검색해보세요".localized
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
        let size = Constant.ScreenSize.deviceScreenWidth - 40
        layout.itemSize = CGSize(width: size/4, height: size/4)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }
}

extension FoodRegisterListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextVC = FoodRegisterDetailViewController()
        nextVC.viewModel.completionHandler = { isSave in
            if isSave {
                self.view.makeToast(Constant.ToastMessage.foodSaveSuccessMessage.localized)
                self.viewModel.isSave.value = true
            }
        }
        
        nextVC.viewModel.foodIconInfo.value = self.viewModel.foodIconInfo.value[indexPath.item]
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: true)
    }
}
