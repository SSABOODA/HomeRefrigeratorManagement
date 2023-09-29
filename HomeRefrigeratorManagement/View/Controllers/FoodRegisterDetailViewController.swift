//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/29.
//

import UIKit

class FoodRegisterDetailViewController: BaseViewController {
    
    let searchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FoodRegisterDetailViewController", #function)

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
        
    }
    
    override func configureLayout() {
    }

    @objc func checkmarkButtonCliecd() {
        print(#function)
    }
    
}
