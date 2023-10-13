//
//  Constant.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

enum Constant {
    enum ScreenSize {
        static let deviceScreenWidth = UIScreen.main.bounds.width
        static let deviceScreenHeight = UIScreen.main.bounds.height
    }

    enum MainView {
        static let mainViewHorizontalPadding = 20
    }
    
    enum StackView {
        static let detailManagementTextFieldStackViewSpacing = 20.0
    }
    
    enum TabBarLayoutDesign {
        static let tabBarBorderWidth: CGFloat = 0.3
    }
    
    enum TabBarSetting {
        static let selectedIndex = 1
    }
}
