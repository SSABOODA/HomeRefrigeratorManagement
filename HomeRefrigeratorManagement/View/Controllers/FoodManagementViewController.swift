//
//  ViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit
import RealmSwift

final class FoodManagementViewController: BaseViewController {
    
    private enum Section: CaseIterable {
        case main
    }
    
    private let mainView = FoodManagementView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Food>!
    
    private let viewModel = FoodManagementViewModel()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        configureDataSource()
        performQuery("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        performQuery("@")
        performQuery("")
    }
    
    @objc func foodRegisterButtonTapped() {
        print(#function)
        showSheet()
    }
    
    override func configureView() {
        // view setting
        mainView.collectionView.delegate = self
        mainView.collectionView.backgroundColor = Constant.collectionViewColor.collectionViewBackgroundColor
        
        configureNavigationBar()
    }
    
    private func addTarget() {
        mainView.foodRegisterButton.addTarget(self, action: #selector(foodRegisterButtonTapped), for: .touchUpInside)
    }
}

// MARK: - navagation
extension FoodManagementViewController {
    func configureNavigationBar() {
        // navigation setting
        title = Constant.NavigationTitle.foodRegisterHomeTitle
        self.mainView.searchController.searchBar.delegate = self
        self.navigationItem.searchController = mainView.searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        // navigation backbutton
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButtonItem.tintColor = Constant.BaseColor.tintColor
        self.navigationItem.backBarButtonItem = backButtonItem
        
        // navigation right button
        let navItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), menu: createMenu())
        navItem.tintColor = .black
        navigationItem.rightBarButtonItem = navItem
        
        func createMenu() -> UIMenu {
            // DB filter
            let nameFilterAction = UIAction(title: "이름 순".localized, image: UIImage(systemName: "arrow.up.arrow.down")) { [weak self] _ in
                guard let self = self else { return }
                self.performQuery("", .name)
                viewModel.isAcending.value.toggle()
            }
            
            let registerDateFilterAction = UIAction(title: "등록일 순".localized, image: UIImage(systemName: "arrow.up.arrow.down")) { [weak self] _ in
                guard let self = self else { return }
                self.performQuery("", .register)
                viewModel.isAcending.value.toggle()
            }
            
            let expirationDateFilterAction = UIAction(title: "유효기간 순".localized, image: UIImage(systemName: "arrow.up.arrow.down")) { [weak self] _ in
                guard let self = self else { return }
                self.performQuery("", .expiration)
                viewModel.isAcending.value.toggle()
            }
            
            let originalFilterMenu = UIMenu(title: "", options: .displayInline, children: [nameFilterAction, registerDateFilterAction, expirationDateFilterAction])
            let menu = UIMenu(title: "정렬", children: [originalFilterMenu])
            return menu
        }
    }
}


// MARK: - UICollectionViewDelegate
extension FoodManagementViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        let nextVC = FoodDetailManagementViewController()
        guard let filteredFoodData = self.viewModel.filteredFoodData else { return }
        let food = filteredFoodData[indexPath.item]
        nextVC.viewModel.food = food
        nextVC.viewModel.completionHandler = { [weak self] isDelete in
            guard let weakSelf = self else {return }
            if isDelete {
                weakSelf.viewModel.deleteFoodData = food
                weakSelf.view.makeToast("식품이 삭제되었습니다.")
            }
        }
        transition(viewController: nextVC, style: .push)
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
            
            cell.configureCell()
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
    
    // TODO: 초성 검색 가능하게 작업해야함.
    private func performQuery(_ searchText: String, _ sortType: SortType = .expiration) {

        let item = viewModel.filterFoodData(searchText, sortType)
        guard let item else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(item.toArray())
        
        // relam 데이터 삭제시 snapshot 처리
        if let deleteFood = viewModel.deleteFoodData, !deleteFood.isInvalidated {
            print("12312312")
            snapshot.deleteItems([deleteFood])
            dataSource.apply(snapshot, animatingDifferences: true)
            RealmTableRepository.shared.delete(object: deleteFood)
        }
        print("456456456")
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension FoodManagementViewController: UISheetPresentationControllerDelegate {
    private func showSheet() {
        let formController = FoodRegisterListViewController()
        
        formController.viewModel.completionHandler = { isSave in
            if isSave {
                self.performQuery("")
            }
        }
        
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
