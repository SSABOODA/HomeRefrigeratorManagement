//
//  LicenseViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/16.
//

import UIKit



final class LicenseViewController: BaseViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.largeTitleDisplayMode = .never
        
        label.attributedText = """
        <a href="https://www.flaticon.com/kr/free-icons/" title="식품 아이콘">망고 아이콘  제작자: Freepik - Flaticon</a>
        """.htmlToAttributedString
    }
    
    override func configureHirarchy() {
        view.addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            
        }
    }
}
