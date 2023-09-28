//
//  ViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

final class FoodManagementViewController: BaseViewController {
    
//    private var searchController = UISearchController(
//    )
    
    private let mainView = FoodManagementView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

