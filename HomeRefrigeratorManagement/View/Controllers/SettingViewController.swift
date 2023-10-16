//
//  SettingViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/26.
//

import UIKit



struct SettingInfo {
    enum SettingCategory: String, CaseIterable {
        case alarm = "알람"
        case notice = "서비스 알림"
        case inquire = "문의"
        case privacy = "개인정보"
        
        var options: [SettingInfo] {
            switch self {
            case .alarm:
                return [
                    SettingInfo(title: "알림 설정", category: self)
                ]
            case .notice:
                return [
                    SettingInfo(title: "공지 사항", category: self),
                    SettingInfo(title: "버전 정보", category: self),
                ]
            case .inquire:
                return [
                    SettingInfo(title: "서비스 제보, 문의", category: self),
                ]
            case .privacy:
                return [
                    SettingInfo(title: "라이선스", category: self),
                    SettingInfo(title: "개인정보 처리 방침", category: self),
                ]
            }
        }
    }

    
    var title: String
    let category: SettingCategory
}


final class SettingViewController: BaseViewController {
    
    var list = SettingInfo.SettingCategory.alarm.options
    
    
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

