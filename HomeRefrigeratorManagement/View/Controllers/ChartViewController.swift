//
//  ChartViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import UIKit
import DGCharts

final class ChartViewController: BaseViewController, UIScrollViewDelegate {

    let mainView = ChartView()
    let viewModel = ChartViewmodel()
    
    var categoryList = [String]()
    var numberOfFoodsByCategory = [Double]()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        dataBind()
        
        customizeChart(dataPoints: categoryList, values: numberOfFoodsByCategory)
        
        print(categoryList, categoryList.count)
        print(numberOfFoodsByCategory, numberOfFoodsByCategory.count)
    }
    
    private func dataBind() {
        viewModel.fetchData()
        categoryList = viewModel.makeFoodCategoryList()
        numberOfFoodsByCategory = viewModel.numberOfFoodsByCategory(categoryList)
    }
    
    override func configureView() {
        super.configureView()
        mainView.scrollView.delegate = self
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    private func setNav() {
        title = Constant.TabBarTitle.chartVC
        changeNavigationCustomFont()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

// pieChart
extension ChartViewController {
    
    private func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.pieChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
}
