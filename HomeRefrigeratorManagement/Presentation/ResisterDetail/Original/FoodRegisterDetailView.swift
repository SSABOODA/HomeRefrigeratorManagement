//
//  FoodRegisterDetailView.swift

import UIKit
import SnapKit
import Then

final class FoodRegisterDetailView: BaseView {
    
    private let mainView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "F6F6F6")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = false
    }
    private let foodView = UIView().then { _ in }
    private let registerView = UIView().then { _ in }
        
    // 상단 음식 아이콘
    private let foodImageShadowView = UIView().then { _ in }
    let foodImageView = UIImageView().then { _ in }
    let foodNameLabel = UILabel().then {
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
    }
    
    // 구분선
    private let divideLineView = UIView().then {
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    // 식품 설명
    private let foodDescriptionLabel = FoodDetailSettingLabel().then {
        $0.text = "식품 설명"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.labelFontSize
        )
    }
    private let foodDescriptionTextFieldView = FoodRegisterComponentTextFieldView().then { _ in }
    lazy var foodDescriptionTextField = CustomTextField().then {
        $0.placeholder = "식품의 상세한 설명을 적어보세요~"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.textFieldFontSize
        )
        $0.tag = FoodDataInputTextFieldTag.desc.rawValue
    }
    
    private lazy var foodDescriptionStackView = UIStackView(
        arrangedSubviews: [
            foodDescriptionLabel,
            foodDescriptionTextFieldView
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    // 등록일
    private let registerDateLabel = FoodDetailSettingLabel().then {
        $0.text = "등록 날짜"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.labelFontSize
        )
    }
    
    private let registerDateTextFieldView = FoodRegisterComponentTextFieldView().then { _ in }
    let registerDateTextField = CustomTextField().then {
        $0.text = Date().dateFormat(date: Date())
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.textFieldFontSize
        )
        $0.tag = FoodDataInputTextFieldTag.register.rawValue
    }
    
    private lazy var registerDateStackView = UIStackView(
        arrangedSubviews: [
            registerDateLabel,
            registerDateTextFieldView
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    // 유통기한
    private let expirationDateLabel = FoodDetailSettingLabel().then {
        $0.text = "유통 기한"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.labelFontSize
        )
    }
    
    private let expirationDateTextFieldView = FoodRegisterComponentTextFieldView().then { _ in }
    
    let expirationDateTextField = CustomTextField().then {
        $0.text = Date().dateFormat(date: Date())
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.textFieldFontSize
        )
        $0.tag = FoodDataInputTextFieldTag.expiration.rawValue
    }
    
    private lazy var expirationDateStackView = UIStackView(
        arrangedSubviews: [
            expirationDateLabel,
            expirationDateTextFieldView
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    // 저장 방법
    private let storageTypeLabel = FoodDetailSettingLabel().then {
        $0.text = "저장 방법"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.labelFontSize
        )
    }
    
    private let storageTypeTextFieldView = FoodRegisterComponentTextFieldView().then { _ in }
    let storageTypeTextField = CustomTextField().then {
        $0.placeholder = "저장 방법을 선택해주세요"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.textFieldFontSize
        )
        $0.tag = FoodDataInputTextFieldTag.storage.rawValue
    }
    private lazy var storageTypeStackView = UIStackView(arrangedSubviews: [storageTypeLabel, storageTypeTextFieldView]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    // 수량
    private let countLabel = FoodDetailSettingLabel().then {
        $0.text = "수량"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.labelFontSize
        )
    }
    
    private let countTextFieldView = FoodRegisterComponentTextFieldView().then { _ in }
    
    let countTextField = CustomTextField().then {
        $0.keyboardType = .numberPad
        $0.placeholder = "수량을 입력해주세요~"
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.textFieldFontSize
        )
        $0.clearButtonMode = .whileEditing
        $0.tag = FoodDataInputTextFieldTag.count.rawValue
    }
    
    private lazy var countStackView = UIStackView(arrangedSubviews: [countLabel, countTextFieldView]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    let cancelButton = UIButton().then {
        $0.setTitle("취소하기", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 13)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .black
    }
    
    let saveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 13)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = Constant.BaseColor.basePointOrangeHexColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        foodImageShadowView.layer.cornerRadius = foodImageShadowView.frame.width / 2
        foodImageShadowView.layoutIfNeeded()
        
        cancelButton.roundCorners(.bottomLeft, radius: 10)
        cancelButton.layoutIfNeeded()
        saveButton.roundCorners(.bottomRight, radius: 10)
        saveButton.layoutIfNeeded()
    }

    override func setupHierarchy() {
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
    
    override func setupConstraints() {
        
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
