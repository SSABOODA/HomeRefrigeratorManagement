//
//  ViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit
import RealmSwift

final class FoodManagementViewController: BaseViewController {
    
    private let mainView = FoodManagementView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Food>!
    
    private var foodData: Results<Food>!
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let data = RealmTableRepository.shared.fetch(object: Food())
//        configureDataSource() // 데이터소스 기반으로 하면 컬렉션뷰 안뜨는거 인식해야함.
//        configureSnapshot(foodData)
        
        mainView.foodRegisterButton.addTarget(self, action: #selector(foodRegisterButtonTapped), for: .touchUpInside)
    }
    
    @objc func foodRegisterButtonTapped() {
        print(#function)
        showSheet()
        
    }
    
    override func configureView() {
        self.navigationItem.searchController = mainView.searchController
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FoodManagementCollectionViewCell, Food> { cell, indexPath, itemIdentifier in
            
            cell.backgroundColor = .darkGray
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
    }
    
    private func configureSnapshot(_ item: Results<Food>) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Food>()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(item))
        dataSource.apply(snapshot)
    }

}

extension FoodManagementViewController: UISheetPresentationControllerDelegate {
    private func showSheet() {
        let formController = FoodRegisterViewController()
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
