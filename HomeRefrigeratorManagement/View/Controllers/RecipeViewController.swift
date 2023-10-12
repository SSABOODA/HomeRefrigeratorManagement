//
//  RecipeViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/12.
//

import UIKit

class RecipeViewController: BaseViewController {
    
    let viewModel = RecipeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, RecipeViewController.description())
        
        viewModel.request(query: "감자")
        
        print(viewModel.youtubeModel.value)
    }
}
