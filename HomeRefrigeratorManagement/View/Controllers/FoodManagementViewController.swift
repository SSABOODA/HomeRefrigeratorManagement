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
    
    private var storageAllButtonIsActive = false
    private var storageOutdoorButtonIsActive = false
    private var storageIceButtonIsActive = false
    private var storageFrozenButtonIsActive = false
    
    var storageButtonArray = [UIButton]()
    var currentStorageType: Constant.FoodStorageType = .all
    var searchText = ""
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        configureDataSource()
        performQuery(searchText: "", storageType: currentStorageType)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function, "FoodManagementViewController")
//        performQuery(searchText: "@", storageType: currentStorageType)
        performQuery(searchText: "", storageType: currentStorageType)
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
        changeNavigationCustomFont()
        self.mainView.searchController.searchBar.delegate = self
        self.navigationItem.searchController = mainView.searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.view.backgroundColor = Constant.BaseColor.backgroundColor
        
        // navigation backbutton
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButtonItem.tintColor = Constant.BaseColor.tintColor
        self.navigationItem.backBarButtonItem = backButtonItem
        
        // navigation right button
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), menu: createMenu())
        sortButton.tintColor = .black
        navigationItem.rightBarButtonItem = sortButton
        
        let chartButton = UIBarButtonItem(image: UIImage(systemName: "chart.pie"), style: .plain, target: self, action: #selector(chartButtonTapped))
        chartButton.tintColor = .black
        
        let consumptionButton = UIBarButtonItem(image: UIImage(systemName: "fork.knife.circle"), style: .plain, target: self, action: #selector(consumptionButtonTapped))
        consumptionButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [sortButton, chartButton, consumptionButton]
        
        func createMenu() -> UIMenu {
            // DB filter
            let nameFilterAction = UIAction(title: "이름 순".localized, image: UIImage(systemName: "arrow.up.arrow.down")) { [weak self] _ in
                guard let self = self else { return }
                self.performQuery(searchText: "", sortType: .name, storageType: currentStorageType)
                viewModel.isAcending.value.toggle()
            }
            
            let registerDateFilterAction = UIAction(title: "등록일 순".localized, image: UIImage(systemName: "arrow.up.arrow.down")) { [weak self] _ in
                guard let self = self else { return }
                self.performQuery(searchText: "", sortType: .register, storageType: currentStorageType)
                viewModel.isAcending.value.toggle()
            }
            
            let expirationDateFilterAction = UIAction(title: "유효기간 순".localized, image: UIImage(systemName: "arrow.up.arrow.down")) { [weak self] _ in
                guard let self = self else { return }
                self.performQuery(searchText: "", sortType: .expiration, storageType: currentStorageType)
                viewModel.isAcending.value.toggle()
            }
            
            let originalFilterMenu = UIMenu(title: "", options: .displayInline, children: [nameFilterAction, registerDateFilterAction, expirationDateFilterAction])
            let menu = UIMenu(title: "정렬", children: [originalFilterMenu])
            
            return menu
        }
    }
    
    @objc func chartButtonTapped() {
        print(#function)
        // TODO: Chart
        let vc = ChartViewController()
        transition(viewController: vc, style: .push)
    }
    
    @objc func consumptionButtonTapped() {
        print(#function)
        let vc = ConsumptionViewController()
        transition(viewController: vc, style: .push)
    }
}

// MARK: - SearchBarDelegate {
extension FoodManagementViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        performQuery(searchText: searchText, storageType: currentStorageType)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.text = ""
        guard let searchText = searchBar.text else { return }
        performQuery(searchText: searchText, storageType: currentStorageType)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}


// MARK: - UICollectionViewDelegate
extension FoodManagementViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let nextVC = FoodDetailManagementViewController()
        guard let filteredFoodDataArray = self.viewModel.filteredFoodDataArray else { return }
        let food = filteredFoodDataArray[indexPath.item]
        nextVC.viewModel.food = food
        nextVC.viewModel.completionHandler = { [weak self] isDelete in
            guard let weakSelf = self else {return }
            if isDelete {
                weakSelf.viewModel.deleteFoodData = food
                weakSelf.view.makeToast(Constant.ToastMessage.foodDeleteSuccessMessage)
            }
        }
        transition(viewController: nextVC, style: .push)
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
            cell.purchaseDateLabel.text = "구매일자: \(itemIdentifier.purchaseDate.toString(format: .compactDot))"
            cell.expirationDateLabel.text = self.viewModel.caculateDday(itemIdentifier.expirationDate)
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: self.mainView.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<FoodManagementCollectionViewHeaderView>(elementKind: FoodManagementViewController.description()) { supplementaryView, elementKind, indexPath in
            self.storageButtonArray.append(supplementaryView.storageAllTypeButton)
            self.storageButtonArray.append(supplementaryView.storageOutdoorTypeButton)
            self.storageButtonArray.append(supplementaryView.storageIceTypeButton)
            self.storageButtonArray.append(supplementaryView.storageFrozenTypeButton)
            var tag = 0
            self.storageButtonArray.forEach {
                $0.addTarget(
                    self,
                    action: #selector(self.storageFilterButtonTapped),
                    for: .touchUpInside
                )
                $0.tag = tag
                tag += 1
            }
            
            self.storageFilterButtoninitialSetting(supplementaryView.storageAllTypeButton)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.mainView.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
    }
    
    private func storageFilterButtoninitialSetting(_ button: UIButton) {
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
    }
    
    @objc func storageFilterButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        
        storageAllButtonIsActive = false
        storageOutdoorButtonIsActive = false
        storageIceButtonIsActive = false
        storageFrozenButtonIsActive = false
        
        if sender.tag == 0 {
            storageAllButtonIsActive.toggle()
        } else if sender.tag == 1 {
            storageOutdoorButtonIsActive.toggle()
        } else if sender.tag == 2 {
            storageIceButtonIsActive.toggle()
        } else {
            storageFrozenButtonIsActive.toggle()
        }
        
        storageFilterButtonUpdateUI(sender.tag)
        storageChoiceWork()
    }
    
    private func storageFilterButtonUpdateUI(_ tag: Int) {
        storageButtonArray[0].backgroundColor = !storageAllButtonIsActive ? .white : .black
        storageButtonArray[1].backgroundColor = !storageOutdoorButtonIsActive ? .white : .black
        storageButtonArray[2].backgroundColor = !storageIceButtonIsActive ? .white : .black
        storageButtonArray[3].backgroundColor = !storageFrozenButtonIsActive ? .white : .black
        storageButtonArray[0].setTitleColor(!storageAllButtonIsActive ? .black : .white, for: .normal)
        storageButtonArray[1].setTitleColor(!storageOutdoorButtonIsActive ? .black : .white, for: .normal)
        storageButtonArray[2].setTitleColor(!storageIceButtonIsActive ? .black : .white, for: .normal)
        storageButtonArray[3].setTitleColor(!storageFrozenButtonIsActive ? .black : .white, for: .normal)
    }
    
    private func storageChoiceWork() {
        if storageAllButtonIsActive {
            print("all 실행")
            viewModel.filterStorageType(.all)
            performQuery(searchText: "", storageType: .all)
            currentStorageType = .all
        } else if storageOutdoorButtonIsActive {
            print("Outdoor 실행")
            viewModel.filterStorageType(.outdoor)
            performQuery(searchText: "", storageType: .outdoor)
            currentStorageType = .outdoor
        } else if storageIceButtonIsActive {
            print("Ice 실행")
            viewModel.filterStorageType(.cold)
            performQuery(searchText: "", storageType: .cold)
            currentStorageType = .cold
        } else {
            print("frozen 실행")
            viewModel.filterStorageType(.frozen)
            performQuery(searchText: "", storageType: .frozen)
            currentStorageType = .frozen
        }
    }
    
    private func performQuery(
        searchText: String,
        sortType: SortType = .expiration,
        storageType: Constant.FoodStorageType
    ) {

        let item = viewModel.filterFoodData(
            query: searchText,
            sortType: sortType,
            storageType: storageType
        )
        
        guard let item else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(item)
        
        // relam 데이터 삭제시 snapshot 처리
        if let deleteFood = viewModel.deleteFoodData, !deleteFood.isInvalidated {
            snapshot.deleteItems([deleteFood])
            dataSource.apply(snapshot, animatingDifferences: true)
            RealmTableRepository.shared.delete(object: deleteFood)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
}

// MARK: - UISheetPresentationControllerDelegate
extension FoodManagementViewController: UISheetPresentationControllerDelegate {
    private func showSheet() {
        let formController = FoodRegisterListViewController()
        
        formController.viewModel.completionHandler = { isSave in
            if isSave {
                self.performQuery(searchText: "", storageType: self.currentStorageType)
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
