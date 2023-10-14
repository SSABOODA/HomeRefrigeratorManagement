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
        label.text = "2023년 10월"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let headerSubTitleLabel = {
        let label = UILabel()
        label.text = "식품에 대한 분석을 살펴보세요"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
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
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    let firstTotalAnalysisImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        return view
    }()
    
    let firstTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = "유통기한을 지키지 못한 식품"
        return label
    }()
    
    let firstTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "35"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .orange
        return label
    }()
    
    let secondTotalAnalysisImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        return view
    }()
    
    let secondTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = "유통기한을 지키지 못한 식품"
        return label
    }()
    
    let secondTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "35"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .orange
        return label
    }()
    
    let thirdTotalAnalysisImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        return view
    }()
    
    let thirdTotalAnalysisContentLabel = {
        let label = UILabel()
        label.text = "유통기한을 지키지 못한 식품"
        return label
    }()
    
    let thirdTotalAnalysisContentInfoLabel = {
        let label = UILabel()
        label.text = "35"
        label.font = .boldSystemFont(ofSize: 20)
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
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        secondTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(firstTotalAnalysisContentStackView.snp.bottom).inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        thirdTotalAnalysisContentStackView.snp.makeConstraints { make in
            make.top.equalTo(secondTotalAnalysisContentStackView.snp.bottom).inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        // chartAnalyView
        chartAnalyView.snp.makeConstraints { make in
            make.top.equalTo(totalAnalysisView.snp.bottom).inset(-15)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(Constant.MainView.mainViewHorizontalPadding)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.3)
        }
        
        

    }
}
