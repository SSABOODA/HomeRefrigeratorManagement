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
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    let viewModel = FoodRegisterListViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, FoodModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        setupSearchBar()
        performQuery(with: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        searchBar.setShowsCancelButton(true, animated: true)
        
        let nsAttributedString = NSAttributedString(
            string: "저장할 식품을 검색해보세요".localized,
            attributes: [NSAttributedString.Key.font: UIFont(name: Constant.Font.pretendardBold, size: 12)!]
        )
        searchBar.searchTextField.attributedPlaceholder = nsAttributedString
        
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            let nsAttributedString = NSAttributedString(
                string: "취소".localized,
                attributes: [NSAttributedString.Key.font: UIFont(name: Constant.Font.pretendardBold, size: 12)!]
            )

            cancelButton.setTitleColor(Constant.BaseColor.tintColor, for: .normal)
            cancelButton.setAttributedTitle(nsAttributedString, for: .normal)
        }
        
        searchBar.setShowsCancelButton(false, animated: true)
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
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        performQuery(with: searchBar.text)
        dismiss(animated: true)
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
                self.view.makeToast(Constant.ToastMessage.foodSaveSuccessMessage)
                self.viewModel.isSave.value = true
            }
        }
        
        nextVC.viewModel.foodIconInfo.value = self.viewModel.foodIconInfo.value[indexPath.item]
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: true)
    }
}
