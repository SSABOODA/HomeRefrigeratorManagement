//
//  ConsumptionCollectionViewCell.swift

import UIKit
import SnapKit

final class ConsumptionCollectionViewCell: BaseCollectionViewCell {
    
    let viewModel = ConsumptionViewModel.shared
    
    let consumptionImageView = FoodIconImageView(frame: .zero).then { _ in }
    
    let nameLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 13)
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }
    
    let countLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 13)
        $0.textAlignment = .center
    }
    
    lazy var minusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "minus"), for: .normal)
        $0.addTarget(self, action: #selector(self.minusButtonTapped(_:)), for: .touchUpInside)
    }
    
    lazy var plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.addTarget(self, action: #selector(self.plusButtonTapped(_:)), for: .touchUpInside)
    }
    
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
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        
        clipsToBounds = false
    }
}
