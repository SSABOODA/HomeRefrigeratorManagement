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
        
        mainView.pieChartTableView.delegate = self
        mainView.pieChartTableView.dataSource = self
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

extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pieChartCell") as? PieChartTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .systemBlue
        cell.colorLabel.backgroundColor = .orange
        cell.categoryLabel.text = "test"
        cell.percentageLabel.text = "10%"
        
        return cell
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
        
        guard let NSFont = NSUIFont(name: Constant.Font.soyoBold, size: 13) else { return }
        pieChartDataSet.valueFont = NSFont
        pieChartDataSet.valueTextColor = NSUIColor(hexCode: "#000000")
        pieChartDataSet.valueLinePart1OffsetPercentage = 0.8
        pieChartDataSet.valueLinePart1Length = 0.5
        pieChartDataSet.valueLinePart2Length = 0.1
        pieChartDataSet.yValuePosition = .outsideSlice
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        mainView.categoryPieChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        
        let hexColors = Constant.ChartColor.FoodCategoryTypeChartColor
        return hexColors.map { UIColor(hexCode: $0) }
    }
}

// UIScrollViewDelegate
extension ChartViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}
