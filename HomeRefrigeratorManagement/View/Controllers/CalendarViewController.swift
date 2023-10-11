//
//  CalendarViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit
import SnapKit
import FSCalendar

final class CalendarViewController: BaseViewController {
    
    let mainView = CalendarView()
    let viewModel = CalendarViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    lazy var currentPage = mainView.calendar.currentPage

    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        setAction()
        print("currentPage: \(currentPage)")
    }

    override func configureView() {
        super.configureView()
        title = "캘린더"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Constant.collectionViewColor.collectionViewBackgroundColor
    }
    
    override func configureLayout() {
    }
    
    private func configureCalendar() {
        self.mainView.calendar.delegate = self
        self.mainView.calendar.dataSource = self
    }
    
    private func setAction() {
        [mainView.prevButton, mainView.nextButton].forEach {
            $0.addTarget(
                self,
                action: #selector(moveMonthButtonDidTap),
                for: .touchUpInside
            )
        }
        
        mainView.calendarTypeChangeButton.addTarget(self, action: #selector(calendarTypeChangeButtonTapped), for: .touchUpInside)
    }
    
    @objc func calendarTypeChangeButtonTapped() {
        if mainView.calendar.scope == .month {
            mainView.calendar.setScope(.week, animated: true)
        } else {
            mainView.calendar.setScope(.month, animated: true)
        }
    }
    
    @objc func moveMonthButtonDidTap(sender: UIButton) {
        moveMonth(next: sender == mainView.nextButton)
    }
    
    // 달 이동 로직
    private func moveMonth(next: Bool) {
        var dateComponents = DateComponents()
        dateComponents.month = next ? 1 : -1
        self.currentPage = Calendar.current.date(byAdding: dateComponents, to: self.currentPage)!
        mainView.calendar.setCurrentPage(self.currentPage, animated: true)
    }
}

extension CalendarViewController: FSCalendarDelegateAppearance, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print(#function)
        mainView.calendar.frame = CGRect(
            origin: mainView.calendar.frame.origin,
            size: bounds.size
        )
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(formatter.string(from: date) + " 선택됨")
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(formatter.string(from: date) + " 해제됨")
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let dateString = self.formatter.string(from: date)
                
        for item in viewModel.foodData {
            let itemDate = self.formatter.string(from: item.expirationDate)
            if itemDate == dateString {
                return UIImage(named: item.name)?.resize(newWidth: 15)
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        switch formatter.string(from: date) {
        case formatter.string(from: Date()):
            return UIColor(hexCode: "#E27749")
        default:
            return nil
        }
    }
    
    // 선택된 날짜의 채워진 색상 지정
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
//        return appearance.selectionColor
//    }
    
    // Custom Cell
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//
//        print(#function)
//        guard let cell = calendar.dequeueReusableCell(
//            withIdentifier: CustomCalendarCell.description(),
//            for: date,
//            at: position
//        ) as? CustomCalendarCell else { return FSCalendarCell() }
//
//        print("IN custom cell")
//        cell.configureCell(date: date, calendar: calendar)
//        return cell
//    }
    
    //선택해제
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        print(#function)
//        return true // 선택해제 가능
//    }
    
    
    
    // 선택된 날짜 테두리 색상
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
//        return Constant.BaseColor.backgroundColor
//    }
    
    // 날짜의 글씨 자체를 오늘로 바꾸기
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        switch formatter.string(from: date) {
//        case formatter.string(from: Date()):
//            return "오늘"
//        default:
//            return nil
//        }
//    }
    
    
    
}
