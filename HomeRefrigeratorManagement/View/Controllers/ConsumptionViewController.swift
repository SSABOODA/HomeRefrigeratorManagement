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
    
    private let mainView = ConsumtionView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Food>!
    private let viewModel = ConsumptionViewModel.shared
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureDataSource()
        searchControllerDelegate()
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
    
    private func searchControllerDelegate() {
        self.mainView.searchController.searchBar.delegate = self
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

extension ConsumptionViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText: \(searchText)")
        performQuery(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        guard let text = searchBar.text else { return }
        performQuery(query: text)
    }
}


// MARK: - configureDataSource

extension ConsumptionViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ConsumptionCollectionViewCell, Food> { cell, indexPath, itemIdentifier in
            
            cell.configureCell()
            
            cell.consumptionImageView.image = UIImage(named: itemIdentifier.name)
            cell.countLabel.text = "\(itemIdentifier.count)"
            cell.nameLabel.text = itemIdentifier.name
            
            cell.minusButton.tag = indexPath.item
            cell.plusButton.tag = indexPath.item
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: self.mainView.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            })
        
        guard let text = mainView.searchController.searchBar.text else { return }
        performQuery(query: text)
    }
    
    private func performQuery(query: String) {
        viewModel.searchFilterData(query)
        print("viewModel.foodDataList.value: \(viewModel.foodDataList.value)")
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.foodDataList.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
