//
//  FoodDetailManagementViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/08.
//

import UIKit

class FoodDetailManagementViewController: BaseViewController {
    
    let viewModel = FoodDetailManagementViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        title = "식품 상세"
        
        navigationBar()
        
        print(viewModel.food)
    }
    
    @objc func updateBarButtonTapped() {
        print(#function)
    }
    
    @objc func deleteBarButtonTapped() {
        print(#function)
        viewModel.deleteData()
        deleteFoodDataAlert {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension FoodDetailManagementViewController {
    private func navigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        
        let updateBarButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(updateBarButtonTapped))
        updateBarButton.tintColor = UIColor(hexCode: "#63A6F3")
        let deleteBarButton = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteBarButtonTapped))
        deleteBarButton.tintColor = UIColor(hexCode: "#E27749")
        
        navigationItem.rightBarButtonItems = [updateBarButton, deleteBarButton]
    }
}
