//
//  CustomTabBarController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureViewController()
        configureTabBarLayout()
    }
    
    private func createTabBarItem(viewContoller: UIViewController, titleString: String, imageString: String, selectedImageString: String) {
        viewContoller.tabBarItem = UITabBarItem(
            title: titleString,
            image: UIImage(systemName: imageString),
            selectedImage: UIImage(systemName: selectedImageString)
        )
    }
    
    private func configureViewController() {
        let vc1 = UINavigationController(rootViewController: RecipeViewController())
        let vc2 = UINavigationController(rootViewController: FoodManagementViewController())
        let vc3 = UINavigationController(rootViewController: SettingViewController())
        
        setViewControllers([vc1, vc2, vc3], animated: true)
        modalPresentationStyle = .fullScreen
        
        createTabBarItem(viewContoller: vc1, titleString: Constant.TabBarTitle.recipeVC, imageString: Constant.SystemImageName.recipeVCTabBarImage, selectedImageString: Constant.SystemImageName.recipeVCTabBarSelectImage)
        
        createTabBarItem(viewContoller: vc2, titleString: Constant.TabBarTitle.foodManagementVC, imageString: Constant.SystemImageName.foodManagementVCTabBarImage, selectedImageString: Constant.SystemImageName.foodManagementVCTabBarSelectImage)
        
        createTabBarItem(viewContoller: vc3, titleString: Constant.TabBarTitle.settingVC, imageString: Constant.SystemImageName.settingVCTabBarImage, selectedImageString: Constant.SystemImageName.settingVCTabBarSelectImage)
    }
    
    private func configureTabBar() {
        self.selectedIndex = Constant.TabBarSetting.selectedIndex
    }
    
    private func configureTabBarLayout() {
        tabBar.tintColor = Constant.BaseColor.tintColor
        tabBar.backgroundColor = Constant.BaseColor.backgroundColor
        
        tabBar.layer.borderColor = Constant.BaseColor.borderColor
        tabBar.layer.borderWidth = Constant.TabBarLayoutDesign.tabBarBorderWidth
        
        tabBar.layer.cornerRadius = tabBar.frame.height * Constant.TabBarLayoutDesign.tabBarBorderWidth
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
