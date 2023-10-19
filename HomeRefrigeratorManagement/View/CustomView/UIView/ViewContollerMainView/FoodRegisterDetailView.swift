//
//  FoodRegisterDetailView.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import UIKit
import SnapKit

final class FoodRegisterDetailView: BaseView {
    
    let mainView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F6F6")
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
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
        return view
    }()
    
    let foodNameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
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
        tf.tag = FoodDataInputTextFieldTag.desc.rawValue
        return tf
    }()
    
    lazy var foodDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodDescriptionLabel, foodDescriptionTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    // 등록일
    let registerDateLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "등록 날짜"
        return label
    }()
    
    let registerDateTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    let registerDateTextField = {
        let tf = UITextField()
        tf.text = Date().dateFormat(date: Date())
        tf.font = .systemFont(ofSize: 13)
        tf.tag = FoodDataInputTextFieldTag.register.rawValue
        return tf
    }()
    
    lazy var registerDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerDateLabel, registerDateTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    // 유통기한
    let expirationDateLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "유통 기한"
        return label
    }()
    
    let expirationDateTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    let expirationDateTextField = {
        let tf = UITextField()
        tf.text = Date().dateFormat(date: Date())
        tf.font = .systemFont(ofSize: 13)
        tf.tag = FoodDataInputTextFieldTag.expiration.rawValue
        return tf
    }()
    
    lazy var expirationDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [expirationDateLabel, expirationDateTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    // 저장 방법
    let storageTypeLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "저장 방법"
        return label
    }()
    
    let storageTypeTextFieldView = {
        let view = FoodRegisterTextFieldView()
        return view
    }()
    
    let storageTypeTextField = {
        let tf = UITextField()
        tf.placeholder = "저장 방법을 선택해주세요"
        tf.font = .systemFont(ofSize: 13)
        tf.tag = FoodDataInputTextFieldTag.storage.rawValue
        return tf
    }()
    
    lazy var storageTypeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [storageTypeLabel, storageTypeTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    // 수량
    let countLabel = {
        let label = FoodDetailSettingLabel()
        label.text = "수량"
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
        tf.font = .systemFont(ofSize: 13)
        tf.tag = FoodDataInputTextFieldTag.count.rawValue
        return tf
    }()
    
    lazy var countStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countLabel, countTextFieldView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    let cancelButton = {
        let button = UIButton()
        button.setTitle("취소하기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    let saveButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Constant.BaseColor.basePointBlueHexColor
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        foodImageShadowView.layer.cornerRadius = foodImageShadowView.frame.width / 2
        foodImageShadowView.layoutIfNeeded()
        
        cancelButton.roundCorners(.bottomLeft, radius: 10)
        cancelButton.layoutIfNeeded()
        saveButton.roundCorners(.bottomRight, radius: 10)
        saveButton.layoutIfNeeded()
    }

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

        mainView.addSubview(cancelButton)
        mainView.addSubview(saveButton)
    }
    
    override func configureLayout() {
        
        mainView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(Constant.ScreenSize.deviceScreenWidth*0.8)
            make.height.equalTo(Constant.ScreenSize.deviceScreenHeight*0.7)
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
            make.size.equalTo(50)
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
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(0.5)
        }
        
        // 식품 설명
        foodDescriptionStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(divideLineView.snp.bottom).offset(30)
            make.width.equalTo(divideLineView.snp.width)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        foodDescriptionLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }

        foodDescriptionTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 등록 날짜
        registerDateStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(foodDescriptionStackView.snp.bottom).offset(20)
            make.width.equalTo(divideLineView.snp.width)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        registerDateLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }

        registerDateTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 유효기간
        expirationDateStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerDateStackView.snp.bottom).offset(20)
            make.width.equalTo(divideLineView.snp.width)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        expirationDateLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }

        expirationDateTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }

        // 저장 방법
        storageTypeStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(expirationDateStackView.snp.bottom).offset(20)
            make.width.equalTo(divideLineView.snp.width)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        storageTypeLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }

        storageTypeTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }

        // 수량
        countStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(storageTypeStackView.snp.bottom).offset(20)
            make.width.equalTo(divideLineView.snp.width)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        countLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        countTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 버튼
        cancelButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.1)
        }

        saveButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
    }
    

    
    
}
