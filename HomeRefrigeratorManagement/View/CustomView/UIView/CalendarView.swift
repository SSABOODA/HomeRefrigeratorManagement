//
//  CalendarView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/10.
//

import UIKit
import SnapKit
import FSCalendar

//UIColor(hexCode: "#E27749")

final class CalendarView: BaseView {
    let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = Constant.BaseColor.backgroundColor
        calendar.placeholderType = .none // 달에 유효하지않은 날짜 지우기
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        
        // 요일 UI 설정
        calendar.appearance.weekdayFont = .boldSystemFont(ofSize: 17)
        calendar.appearance.weekdayTextColor = UIColor(hexCode: "A1A2A5")
        
        // 각각의 일(날짜) 폰트 설정
        calendar.appearance.titleFont = .boldSystemFont(ofSize: 17)
        
        // 다중 선택
//        calendar.allowsMultipleSelection = true
        // 꾹 눌러서 다중 선택
//        calendar.swipeToChooseGesture.isEnabled = true
        
        calendar.appearance.headerDateFormat = "YYYY. M"
        calendar.appearance.headerTitleColor = Constant.BaseColor.tintColor
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerTitleFont = .boldSystemFont(ofSize: 25)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.appearance.eventDefaultColor = UIColor.systemRed
        calendar.appearance.eventSelectionColor = UIColor.systemRed
        
        calendar.appearance.titleSelectionColor = UIColor(hexCode: "#517DD6")
        calendar.appearance.subtitleSelectionColor = UIColor(hexCode: "#517DD6")
        
        calendar.appearance.selectionColor = Constant.BaseColor.backgroundColor
        calendar.appearance.todayColor = .white
        calendar.appearance.todaySelectionColor = .black
        
        calendar.firstWeekday = 2 // 첫 열을 월요일로 지정
        calendar.headerHeight = 70
        calendar.layer.cornerRadius = 10
        
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
    
    override func configureHierarchy() {
        addSubview(calendar)
        addSubview(prevButton)
        addSubview(nextButton)
    }
    
    override func configureLayout() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        prevButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendar.calendarHeaderView).multipliedBy(1.1)
            make.leading.equalTo(calendar.calendarHeaderView.snp.leading).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendar.calendarHeaderView).multipliedBy(1.1)
            make.trailing.equalTo(calendar.calendarHeaderView.snp.trailing).inset(20)
        }
    }
}
