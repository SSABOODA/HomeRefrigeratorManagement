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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBar.tintColor = Constant.BaseColor.tintColor
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if let shadowView = view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" }) {
            shadowView.frame = tabBar.frame
        } else {
            let shadowView = UIView(frame: .zero)
            shadowView.frame = tabBar.frame
            shadowView.accessibilityIdentifier = "TabBarShadow"
            shadowView.backgroundColor = UIColor.white
            shadowView.layer.cornerRadius = tabBar.layer.cornerRadius
            shadowView.layer.maskedCorners = tabBar.layer.maskedCorners
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: -8.0)
            shadowView.layer.shadowOpacity = 0.3
            shadowView.layer.shadowRadius = 10
            view.addSubview(shadowView)
            view.bringSubviewToFront(tabBar)
        }
    }
    
    private func configureTabBarLayout() {}
    
    private func configureTabBar() {
        self.selectedIndex = Constant.TabBarSetting.selectedIndex
    }
}


