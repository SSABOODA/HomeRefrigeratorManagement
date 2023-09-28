//
//  TabBarController+Extension.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit


extension UITabBarController {
    func createTabBarItem(viewContoller: UIViewController, titleString: String, imageString: String, selectedImageString: String) {
        viewContoller.tabBarItem = UITabBarItem(
            title: titleString,
            image: UIImage(systemName: imageString),
            selectedImage: UIImage(systemName: selectedImageString)
        )
    }
}
