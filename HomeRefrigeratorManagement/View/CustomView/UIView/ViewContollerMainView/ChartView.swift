//
//  ChartView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/14.
//

import UIKit

final class ChartView: BaseView {
    // scrollView
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
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
        label.text = "식품에 대한 분석을 살펴보세요"
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
        label.text = "종합 분석"
        label.textAlignment = .center
        label.font = UIFont(name: Constant.Font.soyoBold, size: 25)
        return label
    }()
    
    let firstTotalAnalysisImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "가지")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let firstTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = "현재 냉장고에 보관된 식품"
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    let firstTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "40"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        label.textColor = .orange
        return label
    }()
    
    let secondTotalAnalysisImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "오렌지")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let secondTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = "유통기한 내에 먹은 음식 수"
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    let secondTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "50"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        label.textColor = .orange
        return label
    }()
    
    let thirdTotalAnalysisImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "아스파라거스")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let thirdTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = "유통기한을 지키지 못한 식품"
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    let thirdTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "35"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        label.textColor = .orange
        return label
    }()
    
    lazy var firstTotalAnalysisContentStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstTotalAnalysisImageView,
            firstTotalAnalysisContentLabel,
            firstTotalAnalysisContentInfoLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var secondTotalAnalysisContentStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            secondTotalAnalysisImageView,
            secondTotalAnalysisContentLabel,
            secondTotalAnalysisContentInfoLabel
        ])
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var thirdTotalAnalysisContentStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            thirdTotalAnalysisImageView,
            thirdTotalAnalysisContentLabel,
            thirdTotalAnalysisContentInfoLabel
        ])
        stackView.axis = .horizontal
        return stackView
    }()
    
    // ChartView
    let chartAnalyView = {
        let view = ChartContentView()
        return view
    }()
    
    

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
        contentView.addSubview(chartAnalyView)
        
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
            make.top.horizontalEdges.equalToSuperview().inset(5)
            make.height.equalToSuperview().multipliedBy(0.5)
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
            make.top.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        firstTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(totalAnalysisTitleLabel.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        firstTotalAnalysisImageView.snp.makeConstraints { make in
            make.width.equalTo(firstTotalAnalysisContentStackView.snp.width).multipliedBy(0.1)
        }
        
        secondTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(firstTotalAnalysisContentStackView.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        secondTotalAnalysisImageView.snp.makeConstraints { make in
            make.width.equalTo(secondTotalAnalysisContentStackView.snp.width).multipliedBy(0.1)
        }

        thirdTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(secondTotalAnalysisContentStackView.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        thirdTotalAnalysisImageView.snp.makeConstraints { make in
            make.width.equalTo(thirdTotalAnalysisContentStackView.snp.width).multipliedBy(0.1)
        }
        
        // chartAnalyView
        chartAnalyView.snp.makeConstraints { make in
            make.top.equalTo(totalAnalysisView.snp.bottom).inset(-15)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(Constant.MainView.mainViewHorizontalPadding)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.3)
        }
        
        

    }
}
