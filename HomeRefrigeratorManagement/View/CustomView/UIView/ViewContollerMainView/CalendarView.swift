//
//  CalendarView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/10.
//

import UIKit
import SnapKit
import FSCalendar

final class CalendarView: BaseView {
    
    let calendarTopView = {
        let view = UIView()
        return view
    }()
    
    private let calendarTypeChangeButtonView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        return view
    }()
    
    let calendarTypeChangeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = Constant.BaseColor.tintColor
        return button
    }()
    
    private let calendarHomeResetButtonView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var calendarHomeResetButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        button.tintColor = Constant.BaseColor.tintColor
        return button
    }()
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = Constant.BaseColor.backgroundColor
        calendar.placeholderType = .none // 달에 유효하지않은 날짜 지우기
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        
        // 요일 UI 설정
        calendar.appearance.weekdayFont = UIFont(name: Constant.Font.soyoBold, size: 17)
        calendar.appearance.weekdayTextColor = UIColor(hexCode: "A1A2A5")
        
        // 각각의 일(날짜) 폰트 설정
        calendar.appearance.titleFont = UIFont(name: Constant.Font.soyoBold, size: 16)
        
        // 다중 선택
//        calendar.allowsMultipleSelection = true
        // 꾹 눌러서 다중 선택
//        calendar.swipeToChooseGesture.isEnabled = true
        
        calendar.appearance.headerDateFormat = "YYYY. M"
        calendar.appearance.headerTitleColor = Constant.BaseColor.tintColor
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerTitleFont = UIFont(name: Constant.Font.soyoBold, size: 25)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
//        calendar.appearance.eventDefaultColor = UIColor.systemRed
//        calendar.appearance.eventSelectionColor = UIColor.systemRed
        
        calendar.appearance.titleSelectionColor = UIColor(hexCode: "#517DD6")
        calendar.appearance.subtitleSelectionColor = UIColor(hexCode: "#517DD6")
        
        calendar.appearance.selectionColor = Constant.BaseColor.backgroundColor
        calendar.appearance.todayColor = .white
        calendar.appearance.todaySelectionColor = .white
        
        calendar.firstWeekday = 2 // 첫 열을 월요일로 지정
        calendar.headerHeight = 70
        
        // celendar UI
        calendar.layer.cornerRadius = 10
        calendar.clipsToBounds = false
        
        calendar.layer.shadowColor = UIColor.darkGray.cgColor
        calendar.layer.shadowOffset = CGSize.zero
        calendar.layer.shadowRadius = 1
        calendar.layer.shadowOpacity = 0.5
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: CustomCalendarCell.description())
        return calendar
    }()
    
    // 이전 달로 이동 버튼
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = Constant.BaseColor.tintColor
        return button
    }()
    
    // 다음 달로 이동 버튼
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = Constant.BaseColor.tintColor
        return button
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.alwaysBounceVertical = true
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        print(#function, CalendarView.description())
        
        if calendar.scope == .month {
            calendarTypeChangeButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            calendarTypeChangeButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
    }
    
    override func configureHierarchy() {
        addSubview(calendarTopView)
        calendarTopView.addSubview(calendarTypeChangeButtonView)
        calendarTopView.addSubview(calendarHomeResetButtonView)
        
        calendarTypeChangeButtonView.addSubview(calendarTypeChangeButton)
        calendarHomeResetButtonView.addSubview(calendarHomeResetButton)
        
        addSubview(calendar)
        addSubview(prevButton)
        addSubview(nextButton)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        print(#function)
        calendarTopView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        calendarTypeChangeButtonView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
        }
        
        calendarTypeChangeButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(5)
        }
        
        calendarHomeResetButtonView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(calendarTypeChangeButtonView.snp.leading).inset(-10)
        }
        
        calendarHomeResetButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(5)
        }

        // calendar
        calendar.snp.makeConstraints { make in
            make.top.equalTo(calendarTopView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight/2)
        }
        
        prevButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendar.calendarHeaderView).multipliedBy(1.1)
            make.leading.equalTo(calendar.calendarHeaderView.snp.leading).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendar.calendarHeaderView).multipliedBy(1.1)
            make.trailing.equalTo(calendar.calendarHeaderView.snp.trailing).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).inset(-3)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension CalendarView {
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = Constant.ScreenSize.deviceScreenWidth - 50
        layout.itemSize = CGSize(width: width, height: 100)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 25, right: 0)
        return layout
    }
}
