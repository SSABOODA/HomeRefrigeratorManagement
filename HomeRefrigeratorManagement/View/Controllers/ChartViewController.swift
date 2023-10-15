//
//  ChartViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import UIKit
import DGCharts

final class ChartViewController: BaseViewController {

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
        pieChartDataConfiguration()
        totalAnalysisDataConfiguration()
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
    
    private func pieChartDataConfiguration() {
        viewModel.fetchData()
        categoryList = viewModel.makeFoodCategoryList()
        numberOfFoodsByCategory = viewModel.numberOfFoodsByCategory(categoryList)
        
        customizeChart(
            dataPoints: categoryList,
            values: numberOfFoodsByCategory
        )
    }
    
    private func totalAnalysisDataConfiguration() {
        mainView.firstTotalAnalysisContentInfoLabel.text = "\(viewModel.totalAnalysisData(.totalCurrentFoodCount))"
        mainView.secondTotalAnalysisContentInfoLabel.text = "\(viewModel.totalAnalysisData(.successExpirationDate))"
        mainView.thirdTotalAnalysisContentInfoLabel.text = "\(viewModel.totalAnalysisData(.failedExpirationDate))"
    }
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

// UIScrollViewDelegate
extension ChartViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}
