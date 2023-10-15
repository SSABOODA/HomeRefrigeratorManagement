//
//  SettingViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit

final class SettingViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    private func setNav() {
        title = Constant.TabBarTitle.settingVC
        changeNavigationCustomFont()
    }
}
