//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import UIKit
import Toast

final class FoodRegisterDetailViewController: BaseViewController {
    
    let mainView = FoodRegisterDetailView()
    let viewModel = FoodRegisterDetailViewModel()
    let picker = UIPickerView()
    
    var senderTag = 0
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestures()
        print(#function)
        print(viewModel.foodIconInfo.value)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainView.layoutSubviews()
    }
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        configureInitialDate()
        addTarget()
        configPickerView()
        textFieldDelegate()
    }
    
    private func textFieldDelegate() {
        mainView.foodDescriptionTextField.delegate = self
        mainView.registerDateTextField.delegate = self
        mainView.expirationDateTextField.delegate = self
        mainView.storageTypeTextField.delegate = self
        mainView.countTextField.delegate = self
    }


    private func configureInitialDate() {
        mainView.foodImageView.image = UIImage(named: viewModel.foodIconName)
        mainView.foodNameLabel.text = viewModel.foodIconName
        mainView.storageTypeTextField.text = viewModel.foodIconInfo.value.storageType.rawValue
    }
    
    private func addTarget() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        mainView.foodDescriptionTextField.addTarget(self, action: #selector(foodDescriptionTextEditingChanged), for: .editingChanged)
        mainView.registerDateTextField.addTarget(self, action: #selector(dateTextFieldTapped), for: .touchDown)
        mainView.expirationDateTextField.addTarget(self, action: #selector(dateTextFieldTapped), for: .touchDown)
        mainView.countTextField.addTarget(self, action: #selector(countTextFieldTapped), for: .editingChanged)
    }
    
    private func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapGesture))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc func viewTapGesture() {
        print(#function)
        view.endEditing(true)
    }
    
    @objc func foodDescriptionTextEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        viewModel.foodIconInfo.value.description = text
    }
    
    @objc func dateTextFieldTapped(_ sender: UITextField) {
        print(#function)
        dateFormatterAlert(sender)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        print(#function, "\(sender.date)")
        if senderTag == FoodDataInputTextFieldTag.register.rawValue {
            viewModel.foodIconInfo.value.purchaseDate = sender.date
            mainView.registerDateTextField.text = sender.date.toString(format: .compactDot)
        } else if senderTag == FoodDataInputTextFieldTag.expiration.rawValue {
            viewModel.foodIconInfo.value.expirationDate = sender.date
            mainView.expirationDateTextField.text = sender.date.toString(format: .compactDot)
        }
    }
    
    @objc func countTextFieldTapped(_ sender: UITextField) {
        print(#function)
        guard let text = sender.text else { return }
        guard let count = Int(text) else { return }
        viewModel.foodIconInfo.value.count = count
    }
    
    @objc func cancelButtonTapped() {
        print(#function)
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        print(#function)
        guard let registerDate = mainView.registerDateTextField.text else { return }
        guard let expirationDate = mainView.expirationDateTextField.text else { return }
        
        switch registerDate.compare(expirationDate) {
        case .orderedSame: print("same")
        case .orderedDescending:
            print(">")
            showAlertAction1(
                preferredStyle: .alert,
                title: "유통기한을 구매일보다 더 뒷날로 설정해야합니다."
            )
        case .orderedAscending: print("<")
        }
        
        guard let count = Int(self.mainView.countTextField.text ?? "0") else {
            showAlertAction1(
                preferredStyle: .alert,
                title: Constant.AlertText.noInputFoodCountTitleMessage
            )
            return
        }
        
        updateViewModelData()
        
        viewModel.saveRealmDatabase()
        if viewModel.isSave.value {
            dismiss(animated: true)
        }
    }
}

// UITextFieldDelegate
extension FoodRegisterDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return foodInputDataTextFieldRestriction(textField, string: string)
    }
}

// UIPickerViewDelegate
extension FoodRegisterDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func configPickerView() {
        picker.delegate = self
        picker.dataSource = self
        self.mainView.storageTypeTextField.inputView = picker
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
        self.mainView.storageTypeTextField.inputAccessoryView = toolBar
    }

    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.mainView.storageTypeTextField.text = self.viewModel.storageType[row]
        self.mainView.storageTypeTextField.resignFirstResponder()
    }

    @objc func cancelPicker() {
        self.mainView.storageTypeTextField.text = nil
        self.mainView.storageTypeTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.storageType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.storageType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.mainView.storageTypeTextField.text = self.viewModel.storageType[row]
    }

}

// DatePicker
extension FoodRegisterDetailViewController {
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
    
    func dateFormatterAlert(_ sender: UITextField) {
        // make alert
        let year = Date().year
        let alertMessage = "\(year-5)년 ~ \(year+10)년 까지 연도를 선택할 수 있습니다."
        
        let title = sender.tag == FoodDataInputTextFieldTag.register.rawValue ? "구매 일자" : "유통 기한"
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
}

// updateViewModelData
extension FoodRegisterDetailViewController {
    private func updateViewModelData() {
        
        guard let desc = self.mainView.foodDescriptionTextField.text else { return }
        guard let registerDate = self.mainView.registerDateTextField.text?.toDate() else { return }
        guard let expirationDate = self.mainView.expirationDateTextField.text?.toDate() else { return }
        guard let storageTypeText = self.mainView.storageTypeTextField.text, !storageTypeText.isEmpty else {
            showAlertAction1(
                preferredStyle: .alert,
                title: Constant.AlertText.emptyStorageTitleMessage
            )
            return
        }
        
        guard let count = Int(self.mainView.countTextField.text ?? "0") else { return }
        
        self.viewModel.foodIconInfo.value.description = desc
        self.viewModel.foodIconInfo.value.purchaseDate = registerDate
        self.viewModel.foodIconInfo.value.expirationDate = expirationDate
        self.viewModel.foodIconInfo.value.count = count
        self.viewModel.foodIconInfo.value.storageType = Constant.FoodStorageType(rawValue: storageTypeText) ?? .outdoor
        self.viewModel.isSave.value = true

        print("end: \(viewModel.foodIconInfo.value)")
        
        
    }
}
