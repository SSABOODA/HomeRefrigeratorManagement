//
//  CalendarView.swift

import UIKit
import SnapKit
import FSCalendar
import Then

final class CalendarView: BaseView {
    
    let calendarTopView = UIView().then { _ in }
    private let calendarTypeChangeButtonView = UIView().then { _ in }
    let calendarTypeChangeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        $0.tintColor = Constant.BaseColor.tintColor
    }
    private let calendarHomeResetButtonView = UIView().then { _ in }
    lazy var calendarHomeResetButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        $0.tintColor = Constant.BaseColor.tintColor
    }
    
    let calendar = FSCalendar(frame: .zero).then {
        $0.locale = Locale(identifier: "ko_KR")
        $0.backgroundColor = Constant.BaseColor.backgroundColor
        $0.placeholderType = .none // 달에 유효하지않은 날짜 지우기
        $0.scrollEnabled = true
        $0.scrollDirection = .horizontal
        
        // 요일 UI 설정
        $0.appearance.weekdayFont = UIFont(name: Constant.Font.pretendardBold, size: 17)
        $0.appearance.weekdayTextColor = UIColor(hexCode: "A1A2A5")
        
        // 각각의 일(날짜) 폰트 설정
        $0.appearance.titleFont = UIFont(name: Constant.Font.pretendardBold, size: 16)
        
        // 다중 선택
        // $0.allowsMultipleSelection = true
        // 꾹 눌러서 다중 선택
        // $0.swipeToChooseGesture.isEnabled = true
        
        $0.appearance.headerDateFormat = "YYYY. M"
        $0.appearance.headerTitleColor = Constant.BaseColor.tintColor
        $0.appearance.headerTitleAlignment = .center
        $0.appearance.headerTitleFont = UIFont(name: Constant.Font.pretendardBold, size: 25)
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.titleSelectionColor = UIColor(hexCode: "#517DD6")
        $0.appearance.subtitleSelectionColor = UIColor(hexCode: "#517DD6")
        
        $0.appearance.selectionColor = Constant.BaseColor.backgroundColor
        $0.appearance.todayColor = .white
        $0.appearance.todaySelectionColor = .white
        
        $0.firstWeekday = 2 // 첫 열을 월요일로 지정
        $0.headerHeight = 70
        
        // celendar UI
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexCode: "E8E9EC").cgColor
        $0.clipsToBounds = false
        
        $0.register(
            CustomCalendarCell.self,
            forCellReuseIdentifier: CustomCalendarCell.description()
        )
    }
    
    // 이전 달로 이동 버튼
    let prevButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = Constant.BaseColor.tintColor
    }
    
    // 다음 달로 이동 버튼
    let nextButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = Constant.BaseColor.tintColor
    }
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    ).then {
        $0.alwaysBounceVertical = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if calendar.scope == .month {
            calendarTypeChangeButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            calendarTypeChangeButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }
    
    override func setupHierarchy() {
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
    
    override func setupConstraints() {
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
            make.horizontalEdges.equalToSuperview().inset(20)
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
        let width = Constant.ScreenSize.deviceScreenWidth - 40
        layout.itemSize = CGSize(width: width, height: 100)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 25, right: 0)
        return layout
    }
}
