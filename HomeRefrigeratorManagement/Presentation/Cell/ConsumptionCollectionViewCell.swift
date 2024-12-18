//
//  ConsumptionCollectionViewCell.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/17.
//

import UIKit
import SnapKit

final class ConsumptionCollectionViewCell: BaseCollectionViewCell {
    
    let viewModel = ConsumptionViewModel.shared
    
    let consumptionImageView = {
        let view = FoodIconImageView(frame: .zero)
        return view
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let countLabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    lazy var minusButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(self.minusButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var plusButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(self.plusButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func minusButtonTapped(_ sender: UIButton) {
        guard let text = countLabel.text else { return }
        guard let count = Int(text) else { return }
        if (count-1) < 0 { return }
        countLabel.text = "\(count-1)"
        
        viewModel.updateCount(indexPath: sender.tag, updatedCount: count-1)
    }
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        guard let text = countLabel.text else { return }
        guard let count = Int(text) else { return }
        if (count+1) > 1000 { return }
        countLabel.text = "\(count+1)"
        
        viewModel.updateCount(indexPath: sender.tag, updatedCount: count+1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.fetchData()
    }
 
    
    override func configureHierarchy() {
        addSubview(consumptionImageView)
        addSubview(nameLabel)
        addSubview(countLabel)
        addSubview(minusButton)
        addSubview(plusButton)
    }
    
    override func configureLayout() {
        consumptionImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
            make.size.equalToSuperview().multipliedBy(0.25)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(consumptionImageView.snp.centerX)
            make.top.equalTo(consumptionImageView.snp.bottom).offset(15)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerX.equalTo(consumptionImageView.snp.centerX)
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
        }
        
        minusButton.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.top)
            make.trailing.equalTo(countLabel.snp.leading).offset(-12)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.top)
            make.leading.equalTo(countLabel.snp.trailing).offset(12)
        }
    }
    
    func configureCell() {
        backgroundColor = Constant.collectionViewColor.collectionViewBackgroundColor
        layer.cornerRadius = 10
        clipsToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
    }
}
