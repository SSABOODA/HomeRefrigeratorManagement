//
//  ChartView.swift

import UIKit
import DGCharts
import Then

final class ChartView: BaseView {
    // scrollView
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    // headerView
    private let headerView = ChartContentView().then { _ in }
    
    private let headerTitleLabel = UILabel().then {
        $0.text = Date().toString(format: .compactDot)
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 25)
        $0.textAlignment = .center
    }
    private let headerSubTitleLabel = UILabel().then {
        $0.text = Constant.CharViewTitle.headerSubTitle
        $0.textAlignment = .center
        $0.font = UIFont(name: Constant.Font.pretendardRegular, size: 13)
        $0.textColor = .lightGray
    }
    
    // totalAnalysisView
    private let totalAnalysisView = ChartContentView().then { _ in }
    private let totalAnalysisTitleLabel = UILabel().then {
        $0.text = Constant.CharViewTitle.totalAnalysisTitle
        $0.textAlignment = .center
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 25)
    }
    
    private let firstTotalAnalysisImageView = FoodIconImageView(frame: .zero).then {
        $0.image = UIImage(named: Constant.ImageName.currentStorageCountImageName)
        $0.contentMode = .scaleAspectFit
    }
    
    private let firstTotalAnalysisContentLabel = UILabel().then {
        $0.text = Constant.CharViewTitle.firstTotalAnalysisContentTitle
        $0.font = UIFont(name: Constant.Font.pretendardRegular, size: 13)
        $0.textAlignment = .center
    }
    
    let firstTotalAnalysisContentInfoLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        $0.textColor = .orange
        $0.textAlignment = .right
    }
    
    private let secondTotalAnalysisImageView = FoodIconImageView(frame: .zero).then {
        $0.image = UIImage(named: Constant.ImageName.successExpirationCountImageName)
        $0.contentMode = .scaleAspectFit
    }
    
    private let secondTotalAnalysisContentLabel = UILabel().then {
        $0.text = Constant.CharViewTitle.secondTotalAnalysisContentTitle
        $0.font = UIFont(name: Constant.Font.pretendardRegular, size: 13)
        $0.textAlignment = .center
    }
    
    let secondTotalAnalysisContentInfoLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        $0.textColor = .orange
        $0.textAlignment = .right
    }
    
    private let thirdTotalAnalysisImageView = FoodIconImageView(frame: .zero).then {
        $0.image = UIImage(named: Constant.ImageName.failedExpirationCountImageName)
        $0.contentMode = .scaleAspectFit
    }
    
    private let thirdTotalAnalysisContentLabel = UILabel().then {
        $0.text = Constant.CharViewTitle.thirdTotalAnalysisContentTitle
        $0.font = UIFont(name: Constant.Font.pretendardRegular, size: 13)
        $0.textAlignment = .center
    }
    
    let thirdTotalAnalysisContentInfoLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        $0.textColor = .orange
        $0.textAlignment = .right
    }
    
    private lazy var firstTotalAnalysisContentStackView = UIStackView(
        arrangedSubviews: [
            firstTotalAnalysisImageView,
            firstTotalAnalysisContentLabel,
            firstTotalAnalysisContentInfoLabel
        ]
    ).then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    private lazy var secondTotalAnalysisContentStackView = UIStackView(
        arrangedSubviews: [
            secondTotalAnalysisImageView,
            secondTotalAnalysisContentLabel,
            secondTotalAnalysisContentInfoLabel
        ]
    ).then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    private lazy var thirdTotalAnalysisContentStackView = UIStackView(
        arrangedSubviews: [
            thirdTotalAnalysisImageView,
            thirdTotalAnalysisContentLabel,
            thirdTotalAnalysisContentInfoLabel
        ]
    ).then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    // ChartView
    private let categoryChartAnalyView = ChartContentView().then { _ in }
    private let categoryChartAnalyTitleLabel = UILabel().then {
        $0.text = Constant.CharViewTitle.chartAnalyTitle
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 25)
        $0.textAlignment = .center
    }
    
    private let unitLabel = UILabel().then {
        $0.text = "(단위: 개)"
        $0.textAlignment = .center
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 11)
        $0.textColor = .darkGray
    }
    let categoryPieChartView = PieChartView().then {
        $0.backgroundColor = Constant.BaseColor.backgroundColor
        // 데이터 없을 UI 세팅
        $0.noDataText = "출력할 데이터가 없습니다. 😭".localized
        $0.noDataFont = UIFont(name: Constant.Font.pretendardBold, size: 20)!
        $0.noDataTextColor = .orange
        $0.noDataTextAlignment = .center
        
        $0.usePercentValuesEnabled = true
        $0.transparentCircleRadiusPercent = CGFloat(0)
        $0.legend.enabled = true
        
        // pieChart UI 세팅
        $0.legend.font = UIFont(name: Constant.Font.pretendardRegular, size: 12)!
        $0.entryLabelFont = UIFont(name: Constant.Font.pretendardRegular, size: 10)
        $0.entryLabelColor = .black
        $0.tintColor = .black
        
        $0.legend.horizontalAlignment = .center
        $0.legend.verticalAlignment = .bottom
        $0.animate(yAxisDuration: 2.0, easingOption: .linear)
    }
    
    lazy var pieChartTableView = UITableView().then {
        $0.register(PieChartTableViewCell.self, forCellReuseIdentifier: "pieChartCell")
        $0.rowHeight = Constant.ScreenSize.deviceScreenHeight * 0.1
    }
    
    private let chartView = UIView().then { _ in }

    override func setupHierarchy() {
        // scrollView
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // headerView
        contentView.addSubview(headerView)
        headerView.addSubview(headerTitleLabel)
        headerView.addSubview(headerSubTitleLabel)
        
        // totalAnalysisView
        contentView.addSubview(totalAnalysisView)
        totalAnalysisView.addSubview(totalAnalysisTitleLabel)
        totalAnalysisView.addSubview(firstTotalAnalysisContentStackView)
        totalAnalysisView.addSubview(secondTotalAnalysisContentStackView)
        totalAnalysisView.addSubview(thirdTotalAnalysisContentStackView)
        
        // chartAnalyView
        contentView.addSubview(categoryChartAnalyView)
        categoryChartAnalyView.addSubview(categoryChartAnalyTitleLabel)
        categoryChartAnalyView.addSubview(unitLabel)
        categoryChartAnalyView.addSubview(categoryPieChartView)
        categoryChartAnalyView.addSubview(pieChartTableView)
        
        // temp Chart View
        contentView.addSubview(chartView)
    }
    
    
    override func setupConstraints() {
        // scrollView
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView)
        }
        
        // headerView
        headerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(10)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(Constant.MainView.mainViewHorizontalPadding)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.15)
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        
        headerSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        // totalAnalysisView
        totalAnalysisView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).inset(-15)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(Constant.MainView.mainViewHorizontalPadding)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.3)
        }
        
        totalAnalysisTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        
        firstTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(totalAnalysisTitleLabel.snp.bottom).inset(-20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        firstTotalAnalysisImageView.snp.makeConstraints { make in
            make.width.equalTo(firstTotalAnalysisContentStackView.snp.width).multipliedBy(0.1)
        }
        
        firstTotalAnalysisContentLabel.snp.makeConstraints { make in
            make.width.equalTo(firstTotalAnalysisContentStackView.snp.width).multipliedBy(0.8)
        }
        
        secondTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(firstTotalAnalysisContentStackView.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        secondTotalAnalysisImageView.snp.makeConstraints { make in
            make.width.equalTo(secondTotalAnalysisContentStackView.snp.width).multipliedBy(0.1)
        }
        
        secondTotalAnalysisContentLabel.snp.makeConstraints { make in
            make.width.equalTo(secondTotalAnalysisContentStackView.snp.width).multipliedBy(0.8)
        }
        
        thirdTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(secondTotalAnalysisContentStackView.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        thirdTotalAnalysisImageView.snp.makeConstraints { make in
            make.width.equalTo(thirdTotalAnalysisContentStackView.snp.width).multipliedBy(0.1)
        }
        
        thirdTotalAnalysisContentLabel.snp.makeConstraints { make in
            make.width.equalTo(thirdTotalAnalysisContentStackView.snp.width).multipliedBy(0.8)
        }
        
        // chartAnalyView
        categoryChartAnalyView.snp.makeConstraints { make in
            make.top.equalTo(totalAnalysisView.snp.bottom).inset(-15)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(Constant.MainView.mainViewHorizontalPadding)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.8)
        }
        
        categoryChartAnalyTitleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        
        categoryPieChartView.snp.makeConstraints { make in
            make.top.equalTo(categoryChartAnalyTitleLabel.snp.bottom).inset(-30)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constant.ScreenSize.deviceScreenWidth*0.8)
        }
        
        pieChartTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryPieChartView.snp.bottom).inset(-20)
            make.horizontalEdges.equalTo(categoryPieChartView.snp.horizontalEdges)
            make.bottom.equalToSuperview().inset(10)
        }
        
        // 임시 chartView
        chartView.snp.makeConstraints { make in
            make.top.equalTo(categoryChartAnalyView.snp.bottom).inset(-15)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(Constant.MainView.mainViewHorizontalPadding)
            make.height.equalTo(10)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
}
