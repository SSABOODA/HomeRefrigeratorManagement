//
//  FoodManagementCollectionViewCell.swift

import UIKit
import SnapKit
import Then

final class FoodManagementCollectionViewCell: BaseCollectionViewCell {
    let foodImageView = UIImageView().then { _ in }
    let nameLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        $0.textColor = Constant.BaseColor.tintColor
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 13)
        $0.textColor = Constant.BaseColor.tintColor
        $0.numberOfLines = 1
    }
    
    let purchaseDateLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardRegular, size: 13)
        $0.textColor = Constant.BaseColor.tintColor
        $0.numberOfLines = 1
    }
    
    lazy var stackView = UIStackView(
        arrangedSubviews: [
            nameLabel,
            descriptionLabel,
            purchaseDateLabel]).then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    let expirationDateLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        $0.textColor = UIColor(hexCode: "#E27749")
        $0.textAlignment = .right
        $0.text = "D-0"
        $0.numberOfLines = 1
    }
    
    override func configureHierarchy() {
        addSubview(foodImageView)
        addSubview(stackView)
        addSubview(expirationDateLabel)
    }
    
    override func configureLayout() {
        foodImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalTo(foodImageView.snp.trailing).offset(30)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        expirationDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(50)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    private func shrink(down: Bool) {
      UIView.animate(withDuration: 0.5) {
          if down {
              self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
          } else {
            self.transform = .identity
        }
      }
    }
    
    func configureCell() {
        backgroundColor = Constant.collectionViewColor.collectionViewCellBackgroundColor
        clipsToBounds = false
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexCode: "#E8E9EC").cgColor
        layer.cornerRadius = 10
    }
}
