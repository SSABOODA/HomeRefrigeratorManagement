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
        let vc1 = UINavigationController(rootViewController: CalendarViewController())
        let vc2 = UINavigationController(rootViewController: FoodManagementViewController())
        let vc3 = UINavigationController(rootViewController: SettingViewController())
        
        setViewControllers([vc1, vc2, vc3], animated: true)
        modalPresentationStyle = .fullScreen
        
        createTabBarItem(
            viewContoller: vc1,
            titleString: Constant.TabBarTitle.calendarVC,
            imageString: Constant.SystemImageName.calendarVCTabBarImage,
            selectedImageString: Constant.SystemImageName.calendarVCTabBarSelectImage
        )
        
        createTabBarItem(
            viewContoller: vc2,
            titleString: Constant.TabBarTitle.foodManagementVC,
            imageString: Constant.SystemImageName.foodManagementVCTabBarImage,
            selectedImageString: Constant.SystemImageName.foodManagementVCTabBarSelectImage
        )
        
        createTabBarItem(
            viewContoller: vc3,
            titleString: Constant.TabBarTitle.settingVC,
            imageString: Constant.SystemImageName.settingVCTabBarImage,
            selectedImageString: Constant.SystemImageName.settingVCTabBarSelectImage
        )
    }
    
    private func configureTabBarLayout() {
        tabBar.tintColor = Constant.BaseColor.tintColor
        tabBar.backgroundColor = Constant.BaseColor.backgroundColor
        
        tabBar.layer.borderColor = Constant.BaseColor.borderColor
        tabBar.layer.borderWidth = Constant.TabBarLayoutDesign.tabBarBorderWidth
        
//        tabBar.layer.cornerRadius = tabBar.frame.height * Constant.TabBarLayoutDesign.tabBarBorderWidth
//        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func configureTabBar() {
        self.selectedIndex = Constant.TabBarSetting.selectedIndex
    }
}


