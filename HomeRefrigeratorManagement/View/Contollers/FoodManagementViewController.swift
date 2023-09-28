//
//  ViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

final class FoodManagementViewController: BaseViewController {
    
    private let mainView = FoodManagementView()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        RealmTableRepository.shared.findFileURL()
        
    }
    
    override func configureView() {
        self.navigationItem.searchController = mainView.searchController
    }
    
//    func configureSnapshot(_ item: Photo) {
//        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
//        snapshot.appendSections([0])
//        snapshot.appendItems(item.results)
//        dataSource.apply(snapshot)
//    }


}

