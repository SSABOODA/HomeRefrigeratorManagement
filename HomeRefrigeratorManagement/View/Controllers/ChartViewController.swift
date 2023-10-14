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
        title = "분석"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constant.Font.soyoBold, size: Constant.FontSize.navigationLargeTitleFontSize)!]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constant.Font.soyoBold, size: 15)!]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}
