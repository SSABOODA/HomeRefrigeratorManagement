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
        configureViewController()
        configureTabBarLayout()
        configureTabBar()
    }
    
    private func configureViewController() {
        let CalendarVC = UINavigationController(rootViewController: CalendarViewController())
//        let RecipeVC = UINavigationController(rootViewController: RecipeViewController())
        let FoodManagementVC = UINavigationController(rootViewController: FoodManagementViewController())
        let SettingVC = UINavigationController(rootViewController: SettingViewController())
        
        setViewControllers(
            [
                CalendarVC,
//                RecipeVC,
                FoodManagementVC,
                SettingVC
            ], animated: true
        )
        
        modalPresentationStyle = .fullScreen
        
        createTabBarItem(
            viewContoller: CalendarVC,
            titleString: Constant.TabBarTitle.calendarVC,
            imageString: Constant.SystemImageName.calendarVCTabBarImage,
            selectedImageString: Constant.SystemImageName.calendarVCTabBarSelectImage
        )
        
//        createTabBarItem(
//            viewContoller: RecipeVC,
//            titleString: Constant.TabBarTitle.recipeVC,
//            imageString: Constant.SystemImageName.recipeVCTabBarImage,
//            selectedImageString: Constant.SystemImageName.recipeVCTabBarSelectImage
//        )
        
        createTabBarItem(
            viewContoller: FoodManagementVC,
            titleString: Constant.TabBarTitle.foodManagementVC,
            imageString: Constant.SystemImageName.foodManagementVCTabBarImage,
            selectedImageString: Constant.SystemImageName.foodManagementVCTabBarSelectImage
        )
        
        createTabBarItem(
            viewContoller: SettingVC,
            titleString: Constant.TabBarTitle.settingVC,
            imageString: Constant.SystemImageName.settingVCTabBarImage,
            selectedImageString: Constant.SystemImageName.settingVCTabBarSelectImage
        )
    }
    
    private func configureTabBarLayout() {
        tabBar.tintColor = Constant.BaseColor.tintColor
        tabBar.backgroundColor = .white
        
        tabBar.layer.borderColor = Constant.BaseColor.borderColor
        tabBar.layer.borderWidth = Constant.TabBarLayoutDesign.tabBarBorderWidth
        
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.5
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func configureTabBar() {
        self.selectedIndex = Constant.TabBarSetting.selectedIndex
    }
}


