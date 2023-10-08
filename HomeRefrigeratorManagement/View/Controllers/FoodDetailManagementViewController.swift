//
//  FoodDetailManagementViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/08.
//

import UIKit

class FoodDetailManagementViewController: BaseViewController {
    
    let mainView = FoodDetailManagementView()
    
    let viewModel = FoodDetailManagementViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainView.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget()
    }
    
    override func configureView() {
        super.configureView()
        
        navigationBar()
        
        print(viewModel.food)
        
        view.backgroundColor = Constant.collectionViewColor.collectionViewBackgroundColor
    }
    
    func addTarget() {
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        mainView.updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
    }
    
    @objc func updateButtonTapped() {
        print(#function)
    }
    
    @objc func deleteButtonTapped() {
        print(#function)
        deleteFoodDataAlert {
            self.viewModel.deleteData()
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension FoodDetailManagementViewController {
    private func navigationBar() {
        title = Constant.NavigationTitle.foodDetailTitle
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
