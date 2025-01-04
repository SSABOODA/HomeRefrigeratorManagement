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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBar.backgroundColor = .white
        tabBar.tintColor = Constant.BaseColor.basePointOrangeHexColor
        
        let border = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        border.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        tabBar.addSubview(border)
    }
    
    private func configureViewController() {
        let calendarVC = UINavigationController(rootViewController: CalendarViewController())
        let foodManagementVC = UINavigationController(rootViewController: FoodManagementViewController())
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        
        setViewControllers([calendarVC, foodManagementVC, settingVC], animated: true)

        createTabBarItem(
            viewContoller: calendarVC,
            titleString: Constant.TabBarTitle.calendarVC,
            imageString: Constant.SystemImageName.calendarVCTabBarImage,
            selectedImageString: Constant.SystemImageName.calendarVCTabBarSelectImage,
            tag: 0
        )

        createTabBarItem(
            viewContoller: foodManagementVC,
            titleString: Constant.TabBarTitle.foodManagementVC,
            imageString: Constant.SystemImageName.foodManagementVCTabBarImage,
            selectedImageString: Constant.SystemImageName.foodManagementVCTabBarSelectImage,
            tag: 1
        )

        createTabBarItem(
            viewContoller: settingVC,
            titleString: Constant.TabBarTitle.settingVC,
            imageString: Constant.SystemImageName.settingVCTabBarImage,
            selectedImageString: Constant.SystemImageName.settingVCTabBarSelectImage,
            tag: 2
        )
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: Constant.Font.pretendardBold, size: 11)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        modalPresentationStyle = .fullScreen
    }
    
    private func configureTabBarLayout() {}
    
    private func configureTabBar() {
        self.selectedIndex = Constant.TabBarSetting.selectedIndex
    }
    
}
