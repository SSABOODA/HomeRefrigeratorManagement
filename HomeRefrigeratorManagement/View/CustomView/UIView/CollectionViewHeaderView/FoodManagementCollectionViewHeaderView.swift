//
//  FoodManagementCollectionViewHeaderView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/13.
//

import UIKit
import SnapKit

class FoodManagementCollectionViewHeaderView: UICollectionReusableView {
//    enum StorageFilterButton: String {
//    }
    
    let storageAllTypeButton = {
        let button = FoodStorageTypeButton()
        button.setTitle("전체", for: .normal)
        return button
    }()
    
    let storageOutdoorTypeButton = {
        let button = FoodStorageTypeButton()
        button.setTitle("실외", for: .normal)
        return button
    }()
    
    let storageIceTypeButton = {
        let button = FoodStorageTypeButton()
        button.setTitle("냉장", for: .normal)
        return button
    }()
    
    let storageFrozenTypeButton = {
        let button = FoodStorageTypeButton()
        button.setTitle("냉동", for: .normal)
        return button
    }()
    
    let storageTypeView = {
        let view = UIView()
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
        return view
    }()
    
    lazy var storageTypeStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            storageAllTypeButton,
            storageOutdoorTypeButton,
            storageIceTypeButton,
            storageFrozenTypeButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(title: nil)
    }
    
    private func configureHierarchy() {
        addSubview(storageTypeStackView)
        storageTypeStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(-5)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.05)
        }
    }
    
    private func configureView() {
        backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    
    
    func prepare(title: String?) {
//        self.titleLabel.text = title
    }
}
