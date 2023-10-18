//
//  PieChartTableViewCell.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/18.
//

import UIKit
import SnapKit

final class PieChartTableViewCell: UITableViewCell {
    let colorLabel = {
        let label = UILabel()
        return label
    }()
    
    let categoryLabel = {
        let label = UILabel()
        return label
    }()
    
    let percentageLabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configureHirarchy()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHirarchy() {
        contentView.addSubview(colorLabel)
//        contentView.addSubview(categoryLabel)
//        contentView.addSubview(percentageLabel)
        
        colorLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(0.1)
        }
        
//        categoryLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(colorLabel.snp.bottom).offset(-15)
//        }
//        
//        percentageLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-15)
//        }
        
    }
}
