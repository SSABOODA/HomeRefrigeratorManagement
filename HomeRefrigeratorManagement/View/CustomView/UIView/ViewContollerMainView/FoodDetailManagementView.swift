//
//  FoodDetailManagementView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/08.
//

import UIKit

// @deprecated
class FoodDetailManagementView: BaseView {
    
    let mainView = {
        let view = UIView()
        view.backgroundColor = Constant.BaseColor.backgroundColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
    
    // 상단 음식 아이콘
    
    let foodImageShadowView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        return view
    }()
    
    let foodImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "가지")
        return view
    }()
    
    let foodNameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "가지"
        return label
    }()
    
    // 구분선
    let divideLineView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    // 식품 설명
    
    let foodDescriptionLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "식품 설명"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        return label
    }()
    
    let foodDescriptionTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    lazy var foodDescriptionTextField = {
        let tf = UITextField()
        tf.placeholder = "식품의 상세한 설명을 적어보세요~"
        tf.font = .systemFont(ofSize: 13)
        tf.tag = 0
        return tf
    }()
    
    lazy var foodDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodDescriptionLabel, foodDescriptionTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = Constant.StackView.detailManagementTextFieldStackViewSpacing
        return stackView
    }()
    
    // 등록일
    let registerDateLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "등록 날짜"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        return label
    }()
    
    let registerDateTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    let registerDateTextField = {
        let tf = UITextField()
        tf.text = Date().dateFormat(date: Date())
        tf.font = .boldSystemFont(ofSize: 13)
        return tf
    }()
    
    lazy var registerDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerDateLabel, registerDateTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = Constant.StackView.detailManagementTextFieldStackViewSpacing
        return stackView
    }()
    
    // 유통기한
    let expirationDateLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "유통 기한"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        return label
    }()
    
    let expirationDateTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    let expirationDateTextField = {
        let tf = UITextField()
        tf.text = Date().dateFormat(date: Date())
        tf.font = .boldSystemFont(ofSize: 13)
        return tf
    }()
    
    lazy var expirationDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [expirationDateLabel, expirationDateTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = Constant.StackView.detailManagementTextFieldStackViewSpacing
        return stackView
    }()
    
    // 저장 방법
    let storageTypeLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "저장 방법"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        return label
    }()
    
    let storageTypeTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    let storageTypeTextField = {
        let tf = UITextField()
        tf.placeholder = "저장 방법을 선택해주세요"
        tf.font = .boldSystemFont(ofSize: 13)
        return tf
    }()
    
    lazy var storageTypeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [storageTypeLabel, storageTypeTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = Constant.StackView.detailManagementTextFieldStackViewSpacing
        return stackView
    }()
    
    // 수량
    let countLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "수량"
        label.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        return label
    }()
    
    let countTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    let countTextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.placeholder = "수량을 입력해주세요~"
        tf.font = .boldSystemFont(ofSize: 13)
        tf.clearButtonMode = .whileEditing
        tf.tag = 1
        return tf
    }()
    
    lazy var countStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countLabel, countTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = Constant.StackView.detailManagementTextFieldStackViewSpacing
        return stackView
    }()
    
    let deleteButton = {
        let button = UIButton()
        button.setTitle(Constant.ButtonSetTitle.foodDeleteButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    let updateButton = {
        let button = UIButton()
        button.setTitle(Constant.ButtonSetTitle.foodUpdateButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.Font.soyoBold, size: 13)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Constant.BaseColor.basePointColor
        return button
    }()

    override func configureHierarchy() {
        addSubview(mainView)
        mainView.addSubview(foodView)
        mainView.addSubview(registerView)
        
        foodView.addSubview(foodImageShadowView)
        foodImageShadowView.addSubview(foodImageView)
        foodView.addSubview(foodNameLabel)
        
        registerView.addSubview(divideLineView)
        
        registerView.addSubview(foodDescriptionStackView)
        foodDescriptionTextFieldView.addSubview(foodDescriptionTextField)
        
        registerView.addSubview(registerDateStackView)
        registerDateTextFieldView.addSubview(registerDateTextField)
        
        registerView.addSubview(expirationDateStackView)
        expirationDateTextFieldView.addSubview(expirationDateTextField)
        
        registerView.addSubview(storageTypeStackView)
        storageTypeTextFieldView.addSubview(storageTypeTextField)
        
        registerView.addSubview(countStackView)
        countTextFieldView.addSubview(countTextField)
        
        mainView.addSubview(deleteButton)
        mainView.addSubview(updateButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        deleteButton.roundCorners(.bottomLeft, radius: 10)
        updateButton.roundCorners(.bottomRight, radius: 10)
        deleteButton.layoutIfNeeded()
        updateButton.layoutIfNeeded()
    }
    
    override func configureLayout() {
        mainView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(Constant.MainView.mainViewHorizontalPadding)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        foodView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }

        registerView.snp.makeConstraints { make in
            make.top.equalTo(foodView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        foodImageShadowView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(60)
        }
        foodImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(10)
        }
        foodNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(foodImageShadowView.snp.centerX)
            make.top.equalTo(foodImageShadowView.snp.bottom).offset(10)
        }
        divideLineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(0.5)
        }
        
        // 식품 설명
        foodDescriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(divideLineView.snp.bottom).offset(30)
            make.leading.equalTo(divideLineView.snp.leading)
            make.trailing.equalTo(divideLineView.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        foodDescriptionTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 등록 날짜
        registerDateStackView.snp.makeConstraints { make in
            make.top.equalTo(foodDescriptionStackView.snp.bottom).offset(20)
            make.leading.equalTo(divideLineView.snp.leading)
            make.trailing.equalTo(divideLineView.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        registerDateTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 유효기간
        expirationDateStackView.snp.makeConstraints { make in
            make.top.equalTo(registerDateStackView.snp.bottom).offset(20)
            make.leading.equalTo(divideLineView.snp.leading)
            make.trailing.equalTo(divideLineView.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        expirationDateTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 저장 방법
        storageTypeStackView.snp.makeConstraints { make in
            make.top.equalTo(expirationDateStackView.snp.bottom).offset(20)
            make.leading.equalTo(divideLineView.snp.leading)
            make.trailing.equalTo(divideLineView.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        storageTypeTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 수량
        countStackView.snp.makeConstraints { make in
            make.top.equalTo(storageTypeStackView.snp.bottom).offset(20)
            make.leading.equalTo(divideLineView.snp.leading)
            make.trailing.equalTo(divideLineView.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        countTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.width.equalTo(countStackView.snp.width).multipliedBy(0.7)
        }
        
        // 버튼
        deleteButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        updateButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
    }
}
