//
//  FoodDetailSettingLabel.swift

import UIKit

class FoodDetailSettingLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        font = UIFont(name: Constant.Font.pretendardBold, size: 14)
        textAlignment = .left
        textColor = .black
    }
    
}
