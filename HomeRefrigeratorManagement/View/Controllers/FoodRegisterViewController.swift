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
        let button = FoodRegisterButton()
        button.setTitle(Constant.ButtonTitle.foodDirectRegister, for: .normal)
        button.addTarget(self, action: #selector(directRegisterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var cameraRegisterButton = {
        let button = FoodRegisterButton()
        button.setTitle(Constant.ButtonTitle.foodCameraRegister, for: .normal)
        button.addTarget(self, action: #selector(cameraRegisterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func directRegisterButtonTapped() {
        let vc = FoodRegisterDetailViewController()
        transition(viewController: vc, style: .push)
    }
    
    @objc func cameraRegisterButtonTapped() {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constant.NavigationTitle.foodRegisterTitle
        view.backgroundColor = Constant.BaseColor.backgroundColor
    }
    
    override func configureView() {
        view.addSubview(directRegisterButton)
        view.addSubview(cameraRegisterButton)
    }
    
    override func configureLayout() {
        directRegisterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
        }
        
        
        cameraRegisterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
        }
    }
    
}
