//
//  ViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit
import RealmSwift

final class FoodManagementViewController: BaseViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    private let mainView = FoodManagementView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Food>!
    
    let viewModel = FoodManagementViewModel()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        
        viewModel.settingRealmFoodData()
        
        configureDataSource()
        performQuery("")
        
    }
        
    @objc func foodRegisterButtonTapped() {
        print(#function)
        showSheet()
    }
    
    override func configureView() {
        mainView.collectionView.delegate = self
//        mainView.searchController.delegate = self
        mainView.searchController.searchBar.delegate = self
        // view setting
        mainView.collectionView.backgroundColor = UIColor(hexCode: "#F6F6F6")
        
        // navigation setting
        title = Constant.NavigationTitle.foodRegisterHomeTitle
        self.navigationItem.searchController = mainView.searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    private func addTarget() {
        mainView.foodRegisterButton.addTarget(self, action: #selector(foodRegisterButtonTapped), for: .touchUpInside)
    }
}

// MARK: - UICollectionViewDelegate
extension FoodManagementViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: - SearchBarDelegate {
extension FoodManagementViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        performQuery(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.text = ""
        guard let searchText = searchBar.text else { return }
        performQuery(searchText)
    }
}

// MARK: - DataSource

extension FoodManagementViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FoodManagementCollectionViewCell, Food> { cell, indexPath, itemIdentifier in
  
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            cell.foodImageView.image = UIImage(named: itemIdentifier.name)
            cell.nameLabel.text = itemIdentifier.name
            cell.descriptionLabel.text = itemIdentifier.descriptionContent.isEmpty ? itemIdentifier.name : itemIdentifier.descriptionContent
            cell.purchaseDateLabel.text = "구매일자: \(itemIdentifier.purchaseDate.koreanDateFormatToString())"
            cell.expirationDateLabel.text = self.viewModel.caculateDday(itemIdentifier.expirationDate)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    // TODO: 초성 검색 가능하게...
    private func performQuery(_ searchText: String) {

        let item = viewModel.filterFoodData(searchText)
        guard let item else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(item.toArray())
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension FoodManagementViewController: UISheetPresentationControllerDelegate {
    private func showSheet() {
        let formController = FoodRegisterListViewController()
        formController.sheetPresentationController?.delegate = self

        let formNC = UINavigationController(rootViewController: formController)
        formNC.modalPresentationStyle = UIModalPresentationStyle.pageSheet

        if let sheetPresentationController = formNC.presentationController as? UISheetPresentationController {
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.detents = [
                UISheetPresentationController.Detent.medium(),
                UISheetPresentationController.Detent.large()
            ]
        }
        present(formNC, animated: true)
    }
}
