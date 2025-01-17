//
//  NewFoodRegisterDetailView.swift

import UIKit

protocol DatePickerDelegate: AnyObject {
    func changedRegisterDate(date: Date)
    func changedExpirationDate(date: Date)
}

final class FoodInfoInputComponentView: BaseView {
    
    private let title: String
    private let textFieldText: String
    private let placeHolderText: String
    private let textFieldtag: Int
    
    private let descriptionLabel = FoodDetailSettingLabel().then {
        $0.text = ""
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.labelFontSize
        )
    }
    
    private let textFieldContainerView = FoodRegisterComponentTextFieldView().then { _ in }
    lazy var textField = CustomTextField().then {
        $0.text = textFieldText
        $0.placeholder = ""
        $0.font = UIFont(
            name: Constant.Font.pretendardBold,
            size: Constant.FoodCreateViewFontSize.textFieldFontSize
        )
    }
    
    private init(title: String,
                 textFieldText: String,
                 placeHolderText: String,
                 textFieldtag: Int) {
        self.title = title
        self.textFieldText = textFieldText
        self.placeHolderText = placeHolderText
        self.textFieldtag = textFieldtag
        super.init(frame: .zero)
        setupView()
    }
    
    static func create(title: String,
                       textFieldText: String = "",
                       placeHolderText: String,
                       textFieldtag: Int) -> FoodInfoInputComponentView {
        return FoodInfoInputComponentView(
            title: title,
            textFieldText: textFieldText,
            placeHolderText: placeHolderText,
            textFieldtag: textFieldtag
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.descriptionLabel.text = title
        self.textField.placeholder = placeHolderText
        self.textField.tag = textFieldtag
    }
    
    override func setupHierarchy() {
        addSubview(descriptionLabel)
        addSubview(textFieldContainerView)
        textFieldContainerView.addSubview(textField)
    }
    
    override func setupConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        textFieldContainerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        textField.snp.makeConstraints { make in
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
    
    let foodImageView = UIImageView().then {
        $0.image = UIImage(named: "가지")
    }
    let foodNameLabel = UILabel().then {
        $0.text = "음식"
        $0.font = UIFont(name: Constant.Font.pretendardBold, size: 15)
    }
    
    private lazy var inputComponentStackView = UIStackView(
        arrangedSubviews: [
            foodDescriptionComponentView,
            registerDateComponentView,
            expirationDateComponentView,
            storageMethodComponentView,
            itemCountComponentView,
        ]
    ).then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    // 식품 설명
    let foodDescriptionComponentView = FoodInfoInputComponentView.create(
        title: "식품 설명",
        placeHolderText: "식품의 상세한 설명을 적어보세요~",
        textFieldtag: FoodDataInputTextFieldTag.desc.rawValue
    )
    // 등록 날짜
    lazy var registerDateComponentView = FoodInfoInputComponentView.create(
        title: "등록 날짜",
        textFieldText: Date().dateFormat(date: Date()),
        placeHolderText: "",
        textFieldtag: FoodDataInputTextFieldTag.register.rawValue
    ).then {
        $0.textField.inputView = registerDatePicker
    }
    // 소비기한
    lazy var expirationDateComponentView = FoodInfoInputComponentView.create(
        title: "소비기한",
        textFieldText: Date().dateFormat(date: Date()),
        placeHolderText: "",
        textFieldtag: FoodDataInputTextFieldTag.expiration.rawValue
    ).then {
        $0.textField.inputView = expirationDatePicker
    }
    // 저장 방법
    let storageMethodComponentView = FoodInfoInputComponentView.create(
        title: "저장 방법",
        placeHolderText: "저장 방법을 선택해주세요",
        textFieldtag: FoodDataInputTextFieldTag.storage.rawValue
    )
    // 수량
    let itemCountComponentView = FoodInfoInputComponentView.create(
        title: "수량",
        placeHolderText: "수량을 입력해주세요",
        textFieldtag: FoodDataInputTextFieldTag.count.rawValue
    ).then {
        $0.textField.keyboardType = .numberPad
        $0.textField.clearButtonMode = .whileEditing
    }
    
    private lazy var registerDatePicker: UIDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.addTarget(self, action: #selector(startDateChanged), for: .valueChanged)
    }
    
    private lazy var expirationDatePicker: UIDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.addTarget(self, action: #selector(endDateChanged), for: .valueChanged)
    }
    
    weak var delegate: DatePickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDateTextFields()
    }
    
    override func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodNameLabel)
        contentView.addSubview(inputComponentStackView)
    }
    
    override func setupConstraints() {
        // scrollView
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView)
        }
        
        foodImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(36)
        }
        
        foodNameLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(10)
            make.centerX.equalTo(foodImageView.snp.centerX)
            make.height.equalTo(24)
        }
        
        inputComponentStackView.snp.makeConstraints { make in
            make.top.equalTo(foodNameLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func setupDateTextFields() {
        // 시작일 TextField 설정
        registerDateComponentView.textField.inputAccessoryView = createToolbar(selector: #selector(startDoneButtonTapped))
        
        // 종료일 TextField 설정
        expirationDateComponentView.textField.inputAccessoryView = createToolbar(selector: #selector(endDoneButtonTapped))
    }
    
    private func createToolbar(selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "완료",
            style: .done,
            target: self,
            action: selector
        )
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.items = [flexSpace, doneButton]
        return toolbar
    }
    
    // MARK: - Actions
    @objc private func startDateChanged() {
        
        updateTextField(
            registerDateComponentView.textField,
            date: registerDatePicker.date,
            textFieldTagType: .register)
        // 종료일 최소값을 시작일로 설정
        expirationDatePicker.minimumDate = registerDatePicker.date
    }
    
    @objc private func endDateChanged() {
        updateTextField(
            expirationDateComponentView.textField,
            date: expirationDatePicker.date,
            textFieldTagType: .expiration)
    }
    
    @objc private func startDoneButtonTapped() {
        updateTextField(
            registerDateComponentView.textField,
            date: registerDatePicker.date,
            textFieldTagType: .register)
        registerDateComponentView.textField.resignFirstResponder()
    }
    
    @objc private func endDoneButtonTapped() {
        updateTextField(
            expirationDateComponentView.textField,
            date: expirationDatePicker.date,
            textFieldTagType: .expiration)
        expirationDateComponentView.textField.resignFirstResponder()
    }
    
    private func updateTextField(_ textField: UITextField, 
                                 date: Date,
                                 textFieldTagType: FoodDataInputTextFieldTag) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        textField.text = formatter.string(from: date)
        
        switch textFieldTagType {
        case .register:
            delegate?.changedRegisterDate(date: date)
        case .expiration:
            delegate?.changedExpirationDate(date: date)
        default:
            break
        }
    }
}
