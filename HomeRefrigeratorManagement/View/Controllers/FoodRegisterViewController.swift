//
//  FoodRegisterViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/29.
//

import UIKit
import SnapKit

class FoodRegisterViewController: BaseViewController {
    
    lazy var directRegisterButton = {
        let button = UIButton()
        button.setTitle("직접 등록하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(directRegisterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var cameraRegisterButton = {
        let button = UIButton()
        button.setTitle("카메라로 등록하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cameraRegisterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func directRegisterButtonTapped() {
        let vc = FoodRegisterDetailViewController()
        transition(viewController: vc, style: .push)
    }
    
    @objc func cameraRegisterButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(directRegisterButton)
        directRegisterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
        }
        
        view.addSubview(cameraRegisterButton)
        cameraRegisterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
        }
    }
    
    
    
    
    
}
