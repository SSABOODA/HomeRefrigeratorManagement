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
    let viewModel = ChartViewModel()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
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
    
    private func configureNavigationBar() {
        title = Constant.TabBarTitle.chartVC
        changeNavigationCustomFont()
    }
    
    private func pieChartDataConfiguration() {
        viewModel.fetchData()
        customizeChart(
            dataPoints: viewModel.categoryList,
            values: viewModel.numberOfFoodsByCategory
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
        return viewModel.categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pieChartCell") as? PieChartTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.colorImageView.backgroundColor = colorsOfCharts()[indexPath.row]
        cell.categoryLabel.text = viewModel.categoryList[indexPath.row]
        cell.percentageLabel.text = viewModel.makeCategoryPercetage(count: viewModel.numberOfFoodsByCategory[indexPath.row])
        
        return cell
    }
}

// pieChart
extension ChartViewController {
    
    private func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(
                value: Double(values[i] / Double(viewModel.totalFoodCount)),
                label: nil
            )
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = colorsOfCharts()
        
        guard let NSFont = NSUIFont(name: Constant.Font.pretendardBold, size: 12) else { return }
        pieChartDataSet.valueFont = NSFont
        pieChartDataSet.valueTextColor = NSUIColor(hexCode: "#000000")
        pieChartDataSet.valueLinePart1OffsetPercentage = 0.4 // 선깊이
        pieChartDataSet.valueLinePart1Length = 0.1 // 선길이
        pieChartDataSet.valueLinePart2Length = 0.1
        pieChartDataSet.yValuePosition = .outsideSlice
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        mainView.categoryPieChartView.data = pieChartData
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.maximumFractionDigits = 1
        format.multiplier = 1
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: format))
        
        
    }
    
    private func colorsOfCharts() -> [UIColor] {
        let hexColors = Constant.ChartColor.FoodCategoryTypeChartColor
        return hexColors.map { UIColor(hexCode: $0) }
    }
}

// UIScrollViewDelegate
extension ChartViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}
