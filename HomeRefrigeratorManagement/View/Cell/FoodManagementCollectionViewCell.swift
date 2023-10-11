//
//  FoodManagementCollectionViewCell.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit
import SnapKit

final class FoodManagementCollectionViewCell: BaseCollectionViewCell {
    let foodImageView = {
        let view = UIImageView()
        view.layer.shadowColor = Constant.BaseColor.tintColor?.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        return view
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = Constant.BaseColor.tintColor
        return label
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = Constant.BaseColor.tintColor
        label.numberOfLines = 0
        return label
    }()
    
    let purchaseDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = Constant.BaseColor.tintColor
        label.numberOfLines = 1
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, purchaseDateLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let expirationDateLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor(hexCode: "#E27749")
        label.textAlignment = .right
        label.text = "D-0"
        return label
    }()
    
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
            make.size.equalTo(50)
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
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}
