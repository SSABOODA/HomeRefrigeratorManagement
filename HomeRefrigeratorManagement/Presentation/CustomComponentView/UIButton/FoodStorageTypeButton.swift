//
//  FoodStorageTypeButton.swift

import UIKit

final class FoodStorageTypeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setTitleColor(Constant.BaseColor.tintColor, for: .normal)
        titleLabel?.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        backgroundColor = Constant.BaseColor.backgroundColor
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexCode: "#E8E9EC").cgColor
        clipsToBounds = false
    }
}
