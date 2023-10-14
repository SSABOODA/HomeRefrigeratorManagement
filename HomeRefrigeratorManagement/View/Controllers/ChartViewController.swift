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
    
    let list: [String] = [
        "11.01",
        "11.02",
        "11.03",
        "11.04",
        "11.05"
    ]
    
    let priceData: [Double] = [
        100, 101, 102, 103, 104, 105
    ]
    
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        mainView.scrollView.delegate = self
        
        mainView.pieChartView.noDataText = "출력 데이터가 없습니다."
        mainView.pieChartView.noDataFont = UIFont(name: Constant.Font.soyoBold, size: 20)!
        mainView.pieChartView.noDataTextColor = .lightGray
        mainView.pieChartView.backgroundColor = .white
        
        self.setPieData(
            pieChartView: self.mainView.pieChartView,
            pieChartDataEntries: self.entryData(values: self.priceData)
        )
    }
    
    // 데이터 적용하기
    func setPieData(pieChartView: PieChartView, pieChartDataEntries: [ChartDataEntry]) {
        // Entry들을 이용해 Data Set 만들기
        let pieChartdataSet = PieChartDataSet(entries: pieChartDataEntries, label: "매출")
        // DataSet을 차트 데이터로 넣기
        let pieChartData = PieChartData(dataSet: pieChartdataSet)
        // 데이터 출력
        pieChartView.data = pieChartData
    }

    // entry 만들기
    func entryData(values: [Double]) -> [ChartDataEntry] {
        // entry 담을 array
        var pieDataEntries: [ChartDataEntry] = []
        // 담기
        for i in 0 ..< values.count {
            let pieDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            pieDataEntries.append(pieDataEntry)
        }
        // 반환
        return pieDataEntries
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
