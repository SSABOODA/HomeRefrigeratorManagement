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
        tabBar.tintColor = Constant.BaseColor.basePointOrangeHexColor
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
            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            shadowView.layer.shadowOpacity = 0.3
            shadowView.layer.shadowRadius = 2
            view.addSubview(shadowView)
            view.bringSubviewToFront(tabBar)
        }
    }
    
    private func configureViewController() {
        let CalendarVC = UINavigationController(rootViewController: CalendarViewController())
        let FoodManagementVC = UINavigationController(rootViewController: FoodManagementViewController())
        let SettingVC = UINavigationController(rootViewController: SettingViewController())
        
        setViewControllers([CalendarVC, FoodManagementVC, SettingVC], animated: true)

        createTabBarItem(
            viewContoller: CalendarVC,
            titleString: Constant.TabBarTitle.calendarVC,
            imageString: Constant.SystemImageName.calendarVCTabBarImage,
            selectedImageString: Constant.SystemImageName.calendarVCTabBarSelectImage,
            tag: 0
        )

        createTabBarItem(
            viewContoller: FoodManagementVC,
            titleString: Constant.TabBarTitle.foodManagementVC,
            imageString: Constant.SystemImageName.foodManagementVCTabBarImage,
            selectedImageString: Constant.SystemImageName.foodManagementVCTabBarSelectImage,
            tag: 1
        )

        createTabBarItem(
            viewContoller: SettingVC,
            titleString: Constant.TabBarTitle.settingVC,
            imageString: Constant.SystemImageName.settingVCTabBarImage,
            selectedImageString: Constant.SystemImageName.settingVCTabBarSelectImage,
            tag: 2
        )
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: Constant.Font.soyoBold, size: 11)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        modalPresentationStyle = .fullScreen
    }
    
    private func configureTabBarLayout() {}
    
    private func configureTabBar() {
        self.selectedIndex = Constant.TabBarSetting.selectedIndex
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
            let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
            bounceAnimation.duration = TimeInterval(0.3)
            bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
            return bounceAnimation
        }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            // find index if the selected tab bar item, then find the corresponding view and get its image, the view position is offset by 1 because the first item is the background (at least in this case)
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap ({ $0 as? UIImageView }).first else {
                return
            }
        
        print(idx, imageView)

            // animate the imageView
        imageView.layer.add(bounceAnimation, forKey: nil)
        }
}
