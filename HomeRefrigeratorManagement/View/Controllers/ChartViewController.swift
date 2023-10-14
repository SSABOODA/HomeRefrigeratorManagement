//
//  ChartViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import UIKit
import Charts

final class ChartViewController: BaseViewController, UIScrollViewDelegate {

    let mainView = ChartView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        
        mainView.scrollView.delegate = self
    }
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    private func setNav() {
        title = Constant.TabBarTitle.chartVC
        changeNavigationCustomFont()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}
