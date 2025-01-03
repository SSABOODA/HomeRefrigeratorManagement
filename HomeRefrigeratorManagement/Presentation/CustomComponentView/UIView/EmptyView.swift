//
//  EmptyView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/18.
//

import UIKit
import SnapKit

final class EmptyView: BaseView {
    
    let imageView = {
        let view = UIImageView()
        view.image = UIImage(named: "empty")
        return view
    }()
    
    let label = {
        let label = UILabel()
        label.text = "냉장고에 저장된 식품이 없습니다. 식품을 저장하고 관리해보세요.".localized
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: Constant.Font.pretendardBold, size: 13)
        return label
    }()
    
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(label)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(imageView.snp.bottom).inset(-15)
        }
    }
}
