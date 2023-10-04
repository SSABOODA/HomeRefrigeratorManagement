//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/29.
//

import UIKit

class FoodRegisterDetailViewController: BaseViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    let searchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    lazy var collectionView = {
       let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(
            FoodIconCollectionViewCell.self,
            forCellWithReuseIdentifier: FoodIconCollectionViewCell.reuseIdentifier
        )
//        view.delegate = self
//        view.dataSource = self
        return view
    }()
    
    let viewModel = FoodRegisterDetailViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, FoodModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FoodRegisterDetailViewController", #function)
        
        configureDataSource()
    }
    
    override func configureView() {
        title = Constant.NavigationTitle.foodRegisterDetailTitle
        view.backgroundColor = Constant.BaseColor.backgroundColor
        self.navigationItem.searchController = searchController
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constant.SystemImageName.foodRegisterDetailSaveButtonImage),
            style: .plain,
            target: self,
            action: #selector(checkmarkButtonCliecd)
        )
        
        view.addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }

    @objc func checkmarkButtonCliecd() {
        print(#function)
    }

}

// MARK: - DataSource
extension FoodRegisterDetailViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FoodIconCollectionViewCell,FoodModel> { cell, indexPath, itemIdentifier in
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    func performQuery(with filter: String?) {
//        let mountains = mountainsController.filteredMountains(with: filter).sorted { $0.name < $1.name }

        var snapshot = NSDiffableDataSourceSnapshot<Section, FoodModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems([])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


// MARK: - UICollectionViewDataSource

//extension FoodRegisterDetailViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.numberOfItemsInSection()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodIconCollectionViewCell.reuseIdentifier, for: indexPath) as? FoodIconCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        cell.foodIconImageView.image = UIImage(named: viewModel.cellForItemAt(indexPath))
//        cell.foodIconNameLabel.text = viewModel.cellForItemAt(indexPath)
//        return cell
//    }
//}


// MARK: - UICollectionViewFlowLayout

extension FoodRegisterDetailViewController {
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
