//
//  FoodRegisterDetailView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import UIKit
import SnapKit

class FoodRegisterDetailView: BaseView {
    
    let mainView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 30
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let foodView = {
        let view = UIView()
        return view
    }()
    
    let registerView = {
        let view = UIView()
        return view
    }()
    
    let foodImageView = {
        let view = UIImageView()
        return view
    }()
    
    let foodNameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    //
    
    let foodDescriptionLabel = {
        let label = UILabel()
        label.text = "식품 설명"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var foodDescriptionTextField = {
        let tf = UITextField()
        tf.placeholder = "식품의 상세한 설명을 적어보세요~"
        tf.font = .systemFont(ofSize: 13)
        
        return tf
    }()
    
    lazy var foodDescriptionStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                foodDescriptionLabel,
                foodDescriptionTextField
            ]
        )
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    
    let registerDateLabel = {
        let label = UILabel()
        label.text = "등록 날짜"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let registerDateTextField = {
        let label = UILabel()
        return label
    }()
    
    let expirationDateLabel = {
        let label = UILabel()
        return label
    }()
    
    let expirationDateTextField = {
        let tf = UITextField()
        return tf
    }()
    
    let countLabel = {
        let label = UILabel()
        return label
    }
    
    let countTextField = {
        let tf = UITextField()
        return tf
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        foodDescriptionTextField.layer.addBorder([.bottom], color: UIColor.darkGray, width: 3)
    }

    override func configureHierarchy() {
        addSubview(mainView)
        
        mainView.addSubview(foodView)
        mainView.addSubview(registerView)
        
        foodView.addSubview(foodImageView)
        foodView.addSubview(foodNameLabel)
        
        registerView.addSubview(foodDescriptionStackView)
        
//        registerView.addSubview(foodDescriptionLabel)
//        registerView.addSubview(foodDescriptionTextField)
//
//        registerView.addSubview(registerDateLabel)
//        registerView.addSubview(expirationDateTextField)
    }
    
    override func configureLayout() {
        mainView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(110)
        }
        
        foodView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        registerView.snp.makeConstraints { make in
            make.top.equalTo(foodView.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalToSuperview().inset(15)
        }
        
        foodImageView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(40)
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        
        foodNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(foodImageView.snp.centerX)
            make.top.equalTo(foodImageView.snp.bottom).offset(15)
        }
        
        foodDescriptionStackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(6)
            make.height.equalTo(50)
        }
        
        foodDescriptionLabel.snp.makeConstraints { make in
//            make.top.equalTo(foodNameLabel.snp.bottom).offset(50)
//            make.leading.equalToSuperview().inset(25)
            make.width.equalTo(60)
        }
        
//        foodDescriptionTextField.snp.makeConstraints { make in
//            make.top.equalTo(foodNameLabel.snp.bottom).offset(50)
//            make.leading.equalTo(foodDescriptionLabel.snp.trailing).offset(15)
//            make.trailing.equalToSuperview().inset(25)
//        }

    }
    
}
