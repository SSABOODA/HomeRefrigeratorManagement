//
//  BaseViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHirarchy()
        configureLayout()
    }
    
    func configureView() {
        view.backgroundColor = Constant.BaseColor.backgroundColor
    }
    
    func configureHirarchy() {
        
    }
    
    func configureLayout() {
        
    }
}
