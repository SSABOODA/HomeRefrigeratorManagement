//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import UIKit

final class FoodRegisterDetailViewController: BaseViewController {
    
    let mainView = FoodRegisterDetailView()
    let viewModel = FoodRegisterDetailViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        
        print(viewModel.foodIconInfo.value)
    }
    
    
    

    override func configureView() {
        super.configureView()
        
        view.backgroundColor = .systemGray4
        title = "식품 상세 설정"
        
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = barButtonItem
        
        mainView.foodImageView.image = UIImage(named: viewModel.foodIconName)
        mainView.foodNameLabel.text = viewModel.foodIconName
    }
    
    @objc func addButtonTapped() {
        print(#function)
    }
    
}
