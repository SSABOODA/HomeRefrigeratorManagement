//
//  NewFoodRegisterDetailViewController.swift

import UIKit

final class NewFoodRegisterDetailViewController: BaseViewController {
    
    private let mainView = NewFoodRegisterDetailView()
    private var viewModel: NewFoodRegisterDetailViewModel?
    private let picker = UIPickerView()
    private var senderTag = 0
    
    init(viewModel: NewFoodRegisterDetailViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupTapGestures()
        setupInitialData()
        setupAddTarget()
        setupPickerView()
        textFieldDelegate()
        
        mainView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainView.layoutSubviews()
    }
    
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = Constant.BaseColor.grayContrastBackgroundColor
    }
    
    private func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.title = "보관하기"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constant.Font.pretendardSemiBold, size: 16) ?? .boldSystemFont(ofSize: 16)
        ]
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
    }
    
    private func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapGesture))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    private func setupInitialData() {
        mainView.foodImageView.image = UIImage(named: viewModel?.foodIconName ?? "")
        mainView.foodNameLabel.text = viewModel?.foodIconName ?? ""
        mainView.storageMethodComponentView.textField.text = viewModel?.foodIconInfo.value.storageType.rawValue
    }
    
    private func setupAddTarget() {

        mainView.foodDescriptionComponentView.textField.addTarget(
            self,
            action: #selector(foodDescriptionTextEditingChanged),
            for: .editingChanged)
//        mainView.registerDateComponentView.textField.addTarget(
//            self,
//            action: #selector(foodDescriptionTextEditingChanged),
//            for: .touchDown)
//        mainView.expirationDateComponentView.textField.addTarget(
//            self,
//            action: #selector(foodDescriptionTextEditingChanged),
//            for: .touchDown)
        mainView.itemCountComponentView.textField.addTarget(
            self,
            action: #selector(foodDescriptionTextEditingChanged),
            for: .editingChanged)
    }
    
    private func textFieldDelegate() {
        mainView.foodDescriptionComponentView.textField.delegate = self
        mainView.registerDateComponentView.textField.delegate = self
        mainView.expirationDateComponentView.textField.delegate = self
        mainView.storageMethodComponentView.textField.delegate = self
        mainView.itemCountComponentView.textField.delegate = self
    }
    
    @objc
    func saveButtonTapped() {
        print("저장하기")
        
        guard let registerDate = mainView.registerDateComponentView.textField.text else { return }
        guard let expirationDate = mainView.expirationDateComponentView.textField.text else { return }
        
        switch registerDate.compare(expirationDate) {
        case .orderedSame: print("same")
        case .orderedDescending:
            print(">")
            showAlertAction1(
                preferredStyle: .alert,
                title: "소비기한을 구매일보다 더 뒷날로 설정해야합니다."
            )
            return
        case .orderedAscending: print("<")
        }
        
        guard Int(self.mainView.itemCountComponentView.textField.text ?? "0") != nil else {
            showAlertAction1(
                preferredStyle: .alert,
                title: Constant.AlertText.noInputFoodCountTitleMessage
            )
            return
        }
        
        updateViewModelData()
        
        viewModel?.saveRealmDatabase()
        if let isSave = viewModel?.isSave.value, isSave {
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @objc
    func viewTapGesture() {
        view.endEditing(true)
    }
    
    @objc
    func foodDescriptionTextEditingChanged(_ sender: UITextField) {
        
        print(sender.tag)
        
        switch sender.tag {
        case 0:
            guard let text = sender.text else { return }
            viewModel?.foodIconInfo.value.description = text
        case 1:
//            self.dateFormatterAlert(sender)
            break
        case 2:
//            self.dateFormatterAlert(sender)
            break
        case 3:
            break
        case 4:
            guard let text = sender.text else { return }
            guard let count = Int(text) else { return }
            viewModel?.foodIconInfo.value.count = count
        default:
            break
        }
    }
}

// UITextFieldDelegate
extension NewFoodRegisterDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return foodInputDataTextFieldRestriction(textField, string: string)
    }
}

// UIPickerViewDelegate
extension NewFoodRegisterDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func setupPickerView() {
        picker.delegate = self
        picker.dataSource = self
        self.mainView.storageMethodComponentView.textField.inputView = picker
//        configToolbar() // Constraints 오류 때문에 일단 보류
    }
    
    func configToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        doneButton.tintColor = Constant.BaseColor.tintColor
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        cancelButton.tintColor = Constant.BaseColor.tintColor
        
        toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.mainView.storageMethodComponentView.textField.inputAccessoryView = toolBar
    }

    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.mainView.storageMethodComponentView.textField.text = self.viewModel?.storageType[row]
        self.mainView.storageMethodComponentView.textField.resignFirstResponder()
    }

    @objc func cancelPicker() {
        self.mainView.storageMethodComponentView.textField.text = nil
        self.mainView.storageMethodComponentView.textField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.storageType.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.storageType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.mainView.storageMethodComponentView.textField.text = self.viewModel?.storageType[row]
    }

}

extension NewFoodRegisterDetailViewController {
    func dateFormatterAlert(_ sender: UITextField) {
        // make alert
        let year = Date().year
        let alertMessage = "\(year-5)년 ~ \(year+10)년 까지 연도를 선택할 수 있습니다."
        
        let title = sender.tag == FoodDataInputTextFieldTag.register.rawValue ? "구매일자" : "소비기한"
        let alert = UIAlertController(
            title: title,
            message: alertMessage,
            preferredStyle: .actionSheet
        )
        let ok = UIAlertAction(
            title: "선택 완료",
            style: .cancel,
            handler: nil
        )
        alert.addAction(ok)
        
        // make datapicker
        let datePicker = makeDatePicker()
        guard let textFieldDate = sender.text?.toDate() else { return }
        datePicker.date = textFieldDate
        
        senderTag = sender.tag
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        let vc = UIViewController()
        vc.view = datePicker
        alert.setValue(vc, forKey: "contentViewController")
        present(alert, animated: true)
    }
    
    private func makeDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        
        var components = DateComponents()
        components.year = 10
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        components.year = -5
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())

        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        return datePicker
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        if senderTag == FoodDataInputTextFieldTag.register.rawValue {
            viewModel?.foodIconInfo.value.purchaseDate = sender.date
            mainView.registerDateComponentView.textField.text = sender.date.toString(format: .compactDot)
        } else if senderTag == FoodDataInputTextFieldTag.expiration.rawValue {
            viewModel?.foodIconInfo.value.expirationDate = sender.date
            mainView.expirationDateComponentView.textField.text = sender.date.toString(format: .compactDot)
        }
    }
}


// updateViewModelData
extension NewFoodRegisterDetailViewController {
    private func updateViewModelData() {
        
        guard let desc = self.mainView.foodDescriptionComponentView.textField.text else { return }
        guard let registerDate = self.mainView.registerDateComponentView.textField.text?.toDate() else { return }
        guard let expirationDate = self.mainView.expirationDateComponentView.textField.text?.toDate() else { return }
        guard let storageTypeText = self.mainView.storageMethodComponentView.textField.text, !storageTypeText.isEmpty else {
            showAlertAction1(
                preferredStyle: .alert,
                title: Constant.AlertText.emptyStorageTitleMessage
            )
            return
        }
        
        guard let count = Int(self.mainView.itemCountComponentView.textField.text ?? "0") else { return }
        
        self.viewModel?.foodIconInfo.value.description = desc
        self.viewModel?.foodIconInfo.value.purchaseDate = registerDate
        self.viewModel?.foodIconInfo.value.expirationDate = expirationDate
        self.viewModel?.foodIconInfo.value.count = count
        self.viewModel?.foodIconInfo.value.storageType = Constant.FoodStorageType(rawValue: storageTypeText) ?? .outdoor
        self.viewModel?.isSave.value = true
    }
}


extension NewFoodRegisterDetailViewController: DatePickerDelegate {
    
    func changedRegisterDate(date: Date) {
        viewModel?.foodIconInfo.value.purchaseDate = date
    }
    
    func changedExpirationDate(date: Date) {
        viewModel?.foodIconInfo.value.expirationDate = date
    }
    
}
