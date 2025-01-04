//
//  FoodIconCollectionViewCell.swif

import UIKit
import SnapKit
import Then

final class FoodIconCollectionViewCell: BaseCollectionViewCell {
    
    lazy var foodIconImageView = UIImageView().then { _ in }
    let foodIconNameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 13)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    override func configureHierarchy() {
        addSubview(foodIconImageView)
        addSubview(foodIconNameLabel)
    }
    
    override func configureLayout() {
        foodIconImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.center.equalToSuperview()
        }
        
        foodIconNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(foodIconImageView.snp.centerX)
            make.top.equalTo(foodIconImageView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}
