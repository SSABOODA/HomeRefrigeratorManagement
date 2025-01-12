//
//  NewFoodRegisterDetailView.swift

import UIKit

final class FoodInfoInputComponentView: BaseView {
    
    private let title: String
    private let placeHolderText: String
    private let textFieldtag: Int
    
    private let foodDescriptionLabel = FoodDetailSettingLabel().then {
        $0.text = ""
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.labelFontSize
        )
    }
    
    private let foodDescriptionTextFieldView = FoodRegisterComponentTextFieldView().then { _ in }
    lazy var foodDescriptionTextField = CustomTextField().then {
        $0.placeholder = ""
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.textFieldFontSize
        )
    }
    
    private init(title: String,
                 placeHolderText: String,
                 textFieldtag: Int) {
        self.title = title
        self.placeHolderText = placeHolderText
        self.textFieldtag = textFieldtag
        super.init(frame: .zero)
        setupView()
    }
    
    static func create(title: String,
                       placeHolderText: String,
                       textFieldtag: Int) -> FoodInfoInputComponentView {
        return FoodInfoInputComponentView(
            title: title,
            placeHolderText: placeHolderText,
            textFieldtag: textFieldtag
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.foodDescriptionLabel.text = title
        self.foodDescriptionTextField.placeholder = placeHolderText
    }
    
    override func setupHierarchy() {
        addSubview(foodDescriptionLabel)
        addSubview(foodDescriptionTextFieldView)
        foodDescriptionTextFieldView.addSubview(foodDescriptionTextField)
    }
    
    override func setupConstraints() {
        foodDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        foodDescriptionTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(foodDescriptionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(13)
            make.height.equalTo(48)
        }
        foodDescriptionTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}

final class NewFoodRegisterDetailView: BaseView {
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    private lazy var inputComponentStackView = UIStackView(
        arrangedSubviews: [
            foodDescriptionComponentView,
            registerDateComponentView,
            expirationDateComponentView,
            storageMethodComponentView,
            itemCountComponentView,
        ]).then {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 16
        }
    
    // 식품 설명
    private let foodDescriptionComponentView = FoodInfoInputComponentView.create(title: "식품 설명",
                                                                                 placeHolderText: "식품의 상세한 설명을 적어보세요~",
                                                                                 textFieldtag: FoodDataInputTextFieldTag.desc.rawValue)
    // 등록 날짜
    private let registerDateComponentView = FoodInfoInputComponentView.create(title: "등록 날짜",
                                                                              placeHolderText: "",
                                                                              textFieldtag: FoodDataInputTextFieldTag.register.rawValue)
    // 유통 기한
    private let expirationDateComponentView = FoodInfoInputComponentView.create(title: "유통 기한",
                                                                                placeHolderText: "",
                                                                                textFieldtag: FoodDataInputTextFieldTag.expiration.rawValue)
    // 저장 방법
    private let storageMethodComponentView = FoodInfoInputComponentView.create(title: "저장 방법",
                                                                               placeHolderText: "",
                                                                               textFieldtag: FoodDataInputTextFieldTag.storage.rawValue)
    // 수량
    private let itemCountComponentView = FoodInfoInputComponentView.create(title: "식품 설명",
                                                                           placeHolderText: "저장 방법을 선택해주세요",
                                                                           textFieldtag: FoodDataInputTextFieldTag.count.rawValue)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(inputComponentStackView)
    }
    
    override func setupConstraints() {
        // scrollView
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView)
        }
        
        inputComponentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
