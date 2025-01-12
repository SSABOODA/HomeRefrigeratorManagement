//
//  FoodManagementCollectionViewCell.swift

import UIKit
import SnapKit
import Then

final class FoodManagementCollectionViewCell: BaseCollectionViewCell {
    private let foodImageView = UIImageView().then { _ in }
    private let nameLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        $0.textColor = Constant.BaseColor.tintColor
    }
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 13)
        $0.textColor = Constant.BaseColor.tintColor
        $0.numberOfLines = 1
    }
    
    private let purchaseDateLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardRegular, size: 13)
        $0.textColor = Constant.BaseColor.tintColor
        $0.numberOfLines = 1
    }
    
    private lazy var stackView = UIStackView(
        arrangedSubviews: [
            nameLabel,
            descriptionLabel,
            purchaseDateLabel]
    ).then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private let expirationDateLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
        $0.textColor = UIColor(hexCode: "#E27749")
        $0.textAlignment = .right
        $0.text = "D-0"
        $0.numberOfLines = 1
    }
    
    override func setupHierarchy() {
        addSubview(foodImageView)
        addSubview(stackView)
        addSubview(expirationDateLabel)
    }
    
    override func setupLayout() {
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
    
    override func setupAttributes() {
        backgroundColor = Constant.collectionViewColor.collectionViewCellBackgroundColor
        clipsToBounds = false
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexCode: "#E8E9EC").cgColor
        layer.cornerRadius = 10
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
    
    func configureCell(with food: Food, dDay: String) {
        foodImageView.image = UIImage(named: food.name)
        nameLabel.text = food.name
        descriptionLabel.text = food.descriptionContent.isEmpty ? food.name : food.descriptionContent
        purchaseDateLabel.text = "구매일자: \(food.purchaseDate.toString(format: .compactDot))"
        expirationDateLabel.text = dDay
    }
}
