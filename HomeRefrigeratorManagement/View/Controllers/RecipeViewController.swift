//
//  RecipeViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/12.
//

import UIKit

class RecipeViewController: BaseViewController {
    
    let mainView = RecipeView()
    let viewModel = RecipeViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, RecipeViewController.description())
        
//        viewModel.request(query: "감자")
//        print(viewModel.youtubeModel.value)
    }
    
    override func configureView() {
        super.configureView()
        title = "레시피 검색"
        self.navigationItem.searchController = mainView.searchController
    }
}
