//
//  CalendarViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit
import SnapKit
import RealmSwift
import FSCalendar

final class CalendarViewController: BaseViewController {
    
    private enum Section: CaseIterable {
        case main
    }
    
    private let mainView = CalendarView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Food>!
    let viewModel = CalendarViewModel()
    lazy var currentPage = mainView.calendar.currentPage
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        setCalendarAction()
        configureDataSource()
        dataBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function, CalendarViewController.description())
        mainView.calendar.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function, CalendarViewController.description())
    }
    
    private func dataBind() {
        viewModel.filteredFoodData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.performShanshot()
            }
        }
    }

    override func configureView() {
        super.configureView()
        // configure navigation
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
        title = Constant.NavigationTitle.calendarTitle
        navigationItem.largeTitleDisplayMode = .never
        changeNavigationCustomFont()
        
        // CollectionView
        mainView.collectionView.backgroundColor = Constant.collectionViewColor.collectionViewBackgroundColor
        mainView.collectionView.delegate = self
    }
}

// MARK: - DataSource

extension CalendarViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FoodManagementCollectionViewCell, Food> { cell, indexPath, itemIdentifier in
            
            cell.configureCell()
            cell.foodImageView.image = UIImage(named: itemIdentifier.name)
            cell.nameLabel.text = itemIdentifier.name
            cell.descriptionLabel.text = itemIdentifier.descriptionContent.isEmpty ? itemIdentifier.name : itemIdentifier.descriptionContent
            cell.purchaseDateLabel.text = "구매일자: \(itemIdentifier.purchaseDate.toString(format: .compactDot))"
            cell.expirationDateLabel.text = self.viewModel.caculateDday(itemIdentifier.expirationDate)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    private func performShanshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.filteredFoodData.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate

extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = YoutubeWebViewViewController()
        vc.foodDataName = viewModel.filteredFoodData.value[indexPath.item].name
        transition(viewController: vc, style: .presentFullNavigation)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY >= 1 {
            mainView.calendar.setScope(.week, animated: true)
        } else if contentOffsetY <= -1 {
            mainView.calendar.setScope(.month, animated: true)
        }
        view.layoutIfNeeded()
    }
}

// MARK: - FSCalendar

extension CalendarViewController: FSCalendarDelegateAppearance, FSCalendarDataSource {
    
    // Delegate
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        mainView.calendar.snp.updateConstraints { make in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }

    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("선택됨: \(date)")
        viewModel.fetchImminentExpirationDateFoodData(date)
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("해제됨: \(date)")
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let dateString = date.toString(format: .compactUnderscore)
                
        for item in viewModel.foodData {
            let itemDate = item.expirationDate.toString(format: .compactUnderscore)
            if itemDate == dateString {
                
                return UIImage(named: item.name)?.resize(newWidth: 15)
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let compareDate = date.toString(format: .compactUnderscore)
        let today = Date().toString(format: .compactUnderscore)
        switch compareDate {
        case today:
            return UIColor(hexCode: "#E27749")
        default:
            return nil
        }
    }
    
    // Setting
    
    private func configureCalendar() {
        self.mainView.calendar.delegate = self
        self.mainView.calendar.dataSource = self
    }
    
    private func setCalendarAction() {
        [mainView.prevButton, mainView.nextButton].forEach {
            $0.addTarget(
                self,
                action: #selector(moveMonthButtonDidTap),
                for: .touchUpInside
            )
        }
        
        mainView.calendarHomeResetButton.addTarget(self, action: #selector(calendarHomeResetButtonTapped), for: .touchUpInside)
        mainView.calendarTypeChangeButton.addTarget(self, action: #selector(calendarTypeChangeButtonTapped), for: .touchUpInside)
    }
    
    @objc func calendarTypeChangeButtonTapped() {
        if mainView.calendar.scope == .month {
            mainView.calendar.setScope(.week, animated: true)
        } else {
            mainView.calendar.setScope(.month, animated: true)
        }
    }
    
    @objc func calendarHomeResetButtonTapped() {
        print(#function)
        self.mainView.calendar.setCurrentPage(Date(), animated: true)
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
