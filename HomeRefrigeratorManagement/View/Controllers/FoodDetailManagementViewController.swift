//
//  FoodDetailManagementViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/08.
//

import UIKit

final class FoodDetailManagementViewController: BaseViewController {
    
    let mainView = FoodDetailManagementView()
    let viewModel = FoodDetailManagementViewModel()
    let picker = UIPickerView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainView.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget()
        setupTapGestures()
    }
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = Constant.collectionViewColor.collectionViewBackgroundColor
        navigationBar()
        configreData()
        configPickerView()
        
        mainView.countTextField.delegate = self
    }

    private func configreData() {
        guard let food = viewModel.food else { return }
        mainView.foodImageView.image = UIImage(named: food.name)
        mainView.foodNameLabel.text = food.name
        mainView.foodDescriptionTextField.text = food.descriptionContent
        mainView.registerDateTextField.text = Date().dateFormat(date: food.purchaseDate)
        mainView.expirationDateTextField.text = Date().dateFormat(date: food.expirationDate)
        mainView.storageTypeTextField.text = food.storageType?.storageType
        mainView.countTextField.text = String(food.count)
    }
    
    private func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapGesture))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }

    private func addTarget() {
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        mainView.updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        
        mainView.foodDescriptionTextField.addTarget(self, action: #selector(foodDescriptionTextEditingChanged), for: .editingChanged)
        mainView.registerDateTextField.addTarget(self, action: #selector(registerDateTextFieldTapped), for: .touchDown)
        mainView.expirationDateTextField.addTarget(self, action: #selector(expirationDateTextFieldTapped), for: .touchDown)
        mainView.storageTypeTextField.addTarget(self, action: #selector(storageTypeTextFieldEditingChanged), for: .editingChanged)
        mainView.countTextField.addTarget(self, action: #selector(countTextFieldEditingChanged), for: .editingChanged)
    }
    
    @objc func viewTapGesture() {
        print(#function)
        view.endEditing(true)
    }
    
    @objc func foodDescriptionTextEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        viewModel.foodModel.value.description = text
    }
    
    @objc func registerDateTextFieldTapped(_ sender: UITextField) {
        print(#function)
        dateFormatterAlert(sender)
    }
    
    @objc func expirationDateTextFieldTapped(_ sender: UITextField) {
        print(#function)
        dateFormatterAlert(sender)
    }
    
    @objc func dateTextFieldTapped(_ sender: UITextField) {
        print(#function)
        dateFormatterAlert(sender)
    }
    
    @objc func storageTypeTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        viewModel.foodModel.value.storageType = Constant.FoodStorageType(rawValue: text) ?? .outdoor
    }
    
    @objc func countTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let count = Int(text) else { return }
        viewModel.foodModel.value.count = count
    }
    
    @objc func updateButtonTapped() {
        print(#function)
        viewModel.foodModel.value.purchaseDate = mainView.registerDateTextField.text?.toDate() ?? Date()
        viewModel.foodModel.value.expirationDate = mainView.expirationDateTextField.text?.toDate() ?? Date()

        updateFoodDataAlert {
            self.viewModel.updateData()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func deleteButtonTapped() {
        print(#function)
        deleteFoodDataAlert {
            self.viewModel.deleteData()
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension FoodDetailManagementViewController {
    private func navigationBar() {
        title = Constant.NavigationTitle.foodDetailTitle
        self.navigationItem.largeTitleDisplayMode = .never
    }
}

extension FoodDetailManagementViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(#function, string)
//        if Int(string) == nil {
//            return false
//        } else {
//            print(2222)
//            print(string)
//            guard let text = textField.text else { return true }
//            guard let count = Int(text) else { return false }
//            return count <= 100
//        }
//    }
}

extension FoodDetailManagementViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension FoodDetailManagementViewController {
    func dateFormatterAlert(_ sender: UITextField) {
        let alert = UIAlertController(title: "구매 일자", message: nil, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "선택 완료", style: .cancel, handler: nil)
        alert.addAction(ok)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        let vc = UIViewController()
        vc.view = datePicker
        alert.setValue(vc, forKey: "contentViewController")
        present(alert, animated: true)
        
        viewModel.registerDate.bind { date in
            print("date: \(date)")
            sender.text = date
        }
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        viewModel.registerDate.value = Date().dateFormat(date: sender.date)
    }
}
