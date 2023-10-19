//
//  SettingViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit



struct SettingInfo {
    enum SettingCategory: Int, CaseIterable {
        case alarm = 0 //"알람"
        case notice = 1 //"서비스 알림"
        case inquire = 2 //"문의"
        case privacy = 3 //"개인정보"
        
        enum SettingViewType: Int, CaseIterable {
            case alarm = 0, notice, version, inquire, licence, privacy
        }
        
        var options: [SettingInfo] {
            switch self {
            case .alarm:
                return [
                    SettingInfo(title: "알림 설정", sectionCategory: self, itemViewCategory: SettingCategory.SettingViewType.alarm)
                ]
            case .notice:
                return [
                    SettingInfo(title: "공지 사항", sectionCategory: self, itemViewCategory: SettingCategory.SettingViewType.notice),
                    SettingInfo(title: "버전 정보", sectionCategory: self, itemViewCategory: SettingCategory.SettingViewType.version),
                ]
            case .inquire:
                return [
                    SettingInfo(title: "서비스 제보, 문의", sectionCategory: self, itemViewCategory: SettingCategory.SettingViewType.inquire),
                ]
            case .privacy:
                return [
                    SettingInfo(title: "라이센스", sectionCategory: self, itemViewCategory: SettingCategory.SettingViewType.licence),
                    SettingInfo(title: "개인정보 처리 방침", sectionCategory: self, itemViewCategory: SettingCategory.SettingViewType.privacy),
                ]
            }
        }
    }
    
    var title: String
    let sectionCategory: SettingCategory
    let itemViewCategory: SettingCategory.SettingViewType
}


final class SettingViewController: BaseViewController {
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SettingInfo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            // 셀 디자인 및 데이터 처리
            // UIListContentConfiguration
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            
            
            let nsAttributedString = NSAttributedString(
                string: "\(itemIdentifier.title)".localized,
                attributes: [NSAttributedString.Key.font: UIFont(name: Constant.Font.soyoBold, size: 15)!]
            )
            content.attributedText = nsAttributedString
            content.textToSecondaryTextVerticalPadding = 20
            
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
            
            // UIBackgroundConfiguration
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = Constant.BaseColor.backgroundColor
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            cell.backgroundConfiguration = backgroundConfig
        })
        
    }
    
    override func configureView() {
        super.configureView()
        // view
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
        
        // collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setNav() {
        title = Constant.TabBarTitle.settingVC
        changeNavigationCustomFont()
    }
}

extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SettingInfo.SettingCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SettingInfo.SettingCategory.allCases[section].options.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: SettingInfo.SettingCategory.allCases[indexPath.section].options[indexPath.item]
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)

        let viewType = SettingInfo.SettingCategory.allCases[indexPath.section].options[indexPath.item].itemViewCategory

        switch viewType {
        case .alarm:
            print("alarm")
            let vc = AlarmViewController()
            transition(viewController: vc, style: .push)
        case .notice:
            print("notice")
            let vc = NoticeViewController()
            transition(viewController: vc, style: .push)
        case .version: print("version")
        case .inquire:
            print("inquire")
            let vc = InquireViewController()
            transition(viewController: vc, style: .push)
        case .licence:
            print("licence")
            let vc = LicenseViewController()
            transition(viewController: vc, style: .push)
        case .privacy:
            print("privacy")
            let vc = PrivacyViewController()
            transition(viewController: vc, style: .push)
        }
        
    }
}

extension SettingViewController {
    static func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

