//
//  ConsumptionViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/17.
//

import UIKit

final class ConsumptionViewController: BaseViewController {
    
    private enum Section: CaseIterable {
        case main
    }
    
    let mainView = ConsumtionView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Food>!
    let viewModel = ConsumptionViewModel.shared
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureDataSource()
    }
    
    override func configureView() {
        super.configureView()
        
        title = "식품 소비하기"
        
        mainView.collectionView.backgroundColor = Constant.collectionViewColor.collectionViewBackgroundColor
        self.navigationItem.searchController = mainView.searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        saveButton.tintColor = .black
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func configureData() {
        print("여기에요")
        viewModel.fetchData()
    }
    
    @objc func saveButtonTapped() {
        print(#function)
    
        showAlertAction2(
            title: "소비한 식품을 저장하시겠습니까?"
        ) {} _: {
            self.navigationController?.popViewController(animated: true)
        }

    }
}

extension ConsumptionViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ConsumptionCollectionViewCell, Food> { cell, indexPath, itemIdentifier in
            
            cell.configureCell()
            
            cell.consumptionImageView.image = UIImage(named: itemIdentifier.name)
            cell.countLabel.text = "\(itemIdentifier.count)"
            cell.nameLabel.text = itemIdentifier.name
            
            cell.minusButton.tag = indexPath.item
            cell.plusButton.tag = indexPath.item
            
//            cell.minusButton.addTarget(self, action: #selector(self.minusButtonTapped(_:)), for: .touchUpInside)
//            cell.plusButton.addTarget(self, action: #selector(self.plusButtonTapped(_:)), for: .touchUpInside)
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: self.mainView.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            })
        
        performQuery()
    }
    
    private func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.foodDataList.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
//    @objc func minusButtonTapped(_ sender: UIButton) {
//        print(#function, sender.tag)
//    }
//
//    @objc func plusButtonTapped(_ sender: UIButton) {
//        print(#function, sender.tag)
//    }
    
    
}
