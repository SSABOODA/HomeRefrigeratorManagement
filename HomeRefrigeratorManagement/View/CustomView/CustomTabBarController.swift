//
//  CustomTabBarController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = Constant.BaseColor.tintColor
        tabBar.backgroundColor = Constant.BaseColor.backgroundColor
        
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.layer.borderWidth = 0.3
        
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.3
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
