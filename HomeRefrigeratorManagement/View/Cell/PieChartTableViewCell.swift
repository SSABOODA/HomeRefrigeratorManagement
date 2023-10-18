//
//  PieChartTableViewCell.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/18.
//

import UIKit
import SnapKit

final class PieChartTableViewCell: UITableViewCell {
    lazy var colorImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        return view
    }()
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        return label
    }()
    
    let percentageLabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Font.soyoBold, size: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHirarchy()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorImageView.layer.cornerRadius = colorImageView.frame.width / 2
    }
    
    private func configureHirarchy() {
        contentView.addSubview(colorImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(percentageLabel)
        
        colorImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.size.equalTo(15)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(colorImageView.snp.trailing).offset(15)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
        
    }
}
