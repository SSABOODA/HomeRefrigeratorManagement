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
        configureSnapshot(viewModel.realmFoodData)
        
    }
        
    @objc func foodRegisterButtonTapped() {
        print(#function)
        showSheet()
    }
    
    override func configureView() {
        // navigation setting
        title = Constant.NavigationTitle.foodRegisterHomeTitle
        self.navigationItem.searchController = mainView.searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addTarget() {
        mainView.foodRegisterButton.addTarget(self, action: #selector(foodRegisterButtonTapped), for: .touchUpInside)
    }
}

// MARK: - DataSource

extension FoodManagementViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FoodManagementCollectionViewCell, Food> { cell, indexPath, itemIdentifier in
            
            print(cell)
            print(itemIdentifier)
            
            cell.backgroundColor = .darkGray
            cell.foodImageView.image = UIImage(named: itemIdentifier.name)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    private func configureSnapshot(_ item: Results<Food>?) {
        guard let item else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(item.toArray())
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

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
