//
//  ChartView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import UIKit
import DGCharts

final class ChartView: BaseView {
    // scrollView
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = {
        let view = UIView()
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
        return view
    }()
    
    // headerView
    private let headerView = {
        let view = ChartContentView()
        return view
    }()
    
    private let headerTitleLabel = {
        let label = UILabel()
        label.text = Date().toString(format: .compactDot)
        label.font = UIFont(name: Constant.Font.soyoBold, size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let headerSubTitleLabel = {
        let label = UILabel()
        label.text = Constant.CharViewTitle.headerSubTitle
        label.textAlignment = .center
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 13)
        label.textColor = .lightGray
        return label
    }()
    
    // totalAnalysisView
    private let totalAnalysisView = {
        let view = ChartContentView()
        return view
    }()
    
    private let totalAnalysisTitleLabel = {
        let label = UILabel()
        label.text = Constant.CharViewTitle.totalAnalysisTitle
        label.textAlignment = .center
        label.font = UIFont(name: Constant.Font.soyoBold, size: 25)
        return label
    }()
    
    private let firstTotalAnalysisImageView = {
        let view = FoodIconImageView(frame: .zero)
        view.image = UIImage(named: Constant.ImageName.currentStorageCountImageName)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let firstTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = Constant.CharViewTitle.firstTotalAnalysisContentTitle
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    let firstTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        label.textColor = .orange
        label.textAlignment = .right
        return label
    }()
    
    private let secondTotalAnalysisImageView = {
        let view = FoodIconImageView(frame: .zero)
        view.image = UIImage(named: Constant.ImageName.successExpirationCountImageName)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let secondTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = Constant.CharViewTitle.secondTotalAnalysisContentTitle
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    let secondTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        label.textColor = .orange
        label.textAlignment = .right
        return label
    }()
    
    private let thirdTotalAnalysisImageView = {
        let view = FoodIconImageView(frame: .zero)
        view.image = UIImage(named: Constant.ImageName.failedExpirationCountImageName)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let thirdTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = Constant.CharViewTitle.thirdTotalAnalysisContentTitle
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    let thirdTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        label.textColor = .orange
        label.textAlignment = .right
        return label
    }()
    
    private lazy var firstTotalAnalysisContentStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstTotalAnalysisImageView,
            firstTotalAnalysisContentLabel,
            firstTotalAnalysisContentInfoLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var secondTotalAnalysisContentStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            secondTotalAnalysisImageView,
            secondTotalAnalysisContentLabel,
            secondTotalAnalysisContentInfoLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var thirdTotalAnalysisContentStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            thirdTotalAnalysisImageView,
            thirdTotalAnalysisContentLabel,
            thirdTotalAnalysisContentInfoLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    // ChartView
    private let categoryChartAnalyView = {
        let view = ChartContentView()
        return view
    }()
    
    private let categoryChartAnalyTitleLabel = {
        let label = UILabel()
        label.text = Constant.CharViewTitle.chartAnalyTitle
        label.font = UIFont(name: Constant.Font.soyoBold, size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let unitLabel = {
        let label = UILabel()
        label.text = "(단위: 개)"
        label.textAlignment = .center
        label.font = UIFont(name: Constant.Font.soyoBold, size: 11)
        label.textColor = .darkGray
        return label
    }()
    
    let categoryPieChartView = {
        let view = PieChartView()
        view.backgroundColor = Constant.BaseColor.backgroundColor
        // 데이터 없을 UI 세팅
        view.noDataText = "출력할 데이터가 없습니다. 😭".localized
        view.noDataFont = UIFont(name: Constant.Font.soyoBold, size: 20)!
        view.noDataTextColor = .orange
        view.noDataTextAlignment = .center
        
        view.usePercentValuesEnabled = true
        view.transparentCircleRadiusPercent = CGFloat(0)
        view.legend.enabled = true
        
        // pieChart UI 세팅
        view.legend.font = UIFont(name: Constant.Font.soyoRegular, size: 12)!
        view.entryLabelFont = UIFont(name: Constant.Font.soyoRegular, size: 10)
        view.entryLabelColor = .black
        view.tintColor = .black
        
        view.legend.horizontalAlignment = .center
        view.legend.verticalAlignment = .bottom
        view.animate(yAxisDuration: 2.0, easingOption: .linear)
        return view
    }()
    
    lazy var pieChartTableView = {
        let tableView = UITableView()
        tableView.register(PieChartTableViewCell.self, forCellReuseIdentifier: "pieChartCell")
        tableView.rowHeight = Constant.ScreenSize.deviceScreenHeight * 0.1
        return tableView
    }()
    
    private let chartView = {
        let view = UIView()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func configureHierarchy() {
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


    override func configureLayout() {
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
