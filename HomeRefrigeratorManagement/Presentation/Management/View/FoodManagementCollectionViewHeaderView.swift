//
//  FoodManagementCollectionViewHeaderView.swift

import UIKit
import SnapKit
import Then

final class FoodManagementCollectionViewHeaderView: UICollectionReusableView {

    let storageAllTypeButton = FoodStorageTypeButton().then {
        $0.setTitle("전체", for: .normal)
    }
    
    let storageOutdoorTypeButton = FoodStorageTypeButton().then {
        $0.setTitle("실외", for: .normal)
    }
    
    let storageIceTypeButton = FoodStorageTypeButton().then {
        $0.setTitle("냉장", for: .normal)
    }
    
    let storageFrozenTypeButton = FoodStorageTypeButton().then {
        $0.setTitle("냉동", for: .normal)
    }
    
    let storageTypeView = UIView().then {
        $0.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    lazy var storageTypeStackView = UIStackView(
        arrangedSubviews: [
            
            storageAllTypeButton,
            storageOutdoorTypeButton,
            storageIceTypeButton,
            storageFrozenTypeButton
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .fillEqually
    }
    
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
    }
}
