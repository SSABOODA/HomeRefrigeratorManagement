//
//  FoodRegisterDetailViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/05.
//

import UIKit

final class FoodRegisterDetailViewController: BaseViewController {
    
    let mainView = FoodRegisterDetailView()
    let viewModel = FoodRegisterDetailViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        print(viewModel.foodIconInfo.value)
        setupTapGestures()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainView.layoutSubviews()
    }
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        mainView.foodImageView.image = UIImage(named: viewModel.foodIconName)
        mainView.foodNameLabel.text = viewModel.foodIconName
        
        addTarget()
        dataBind()
        
    }
    
    private func dataBind() {
        viewModel.foodIconInfo.bind { [weak self] food in
            guard let self else { return }
        }
    }
    
    private func addTarget() {
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        mainView.foodDescriptionTextField.addTarget(self, action: #selector(foodDescriptionTextFieldTapped), for: .editingChanged)
        mainView.registerDateTextField.addTarget(self, action: #selector(dateTextFieldTapped), for: .touchDown)
        mainView.expirationDateTextField.addTarget(self, action: #selector(dateTextFieldTapped), for: .touchDown)
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
    
    @objc func foodDescriptionTextFieldTapped(_ sender: UITextField) {
        guard let text = sender.text else { return }
        print("text: \(text)")
        viewModel.foodIconInfo.value.description = text
    }
    
    @objc func dateTextFieldTapped(_ sender: UITextField) {
        print(#function)
        dateFormatterAlert(sender)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        viewModel.registerDate.value = Date().dateFormat(date: sender.date)
    }
    
    @objc func cancelButtonTapped() {
        print(#function)
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        print(#function)
        updateViewModelData()
    }
    
}

extension FoodRegisterDetailViewController {
    func dateFormatterAlert(_ sender: UITextField) {
        let alert = UIAlertController(title: "구매 일자", message: nil, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "선택 완료", style: .cancel, handler: nil)
        alert.addAction(ok)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        viewModel.registerDate.bind { date in
            print("date: \(date)")
            sender.text = date
        }
        
        let vc = UIViewController()
        vc.view = datePicker
        alert.setValue(vc, forKey: "contentViewController")
        present(alert, animated: true)
    }
    
    func updateViewModelData() {
        guard let desc = self.mainView.foodDescriptionTextField.text else { return }
        guard let registerDate = self.mainView.registerDateTextField.text?.toDate() else { return }
        guard let expirationDate = self.mainView.expirationDateTextField.text?.toDate() else { return }
        guard let count = Int(self.mainView.countTextField.text ?? "0") else { return }

        viewModel.foodIconInfo.value.description = desc
        viewModel.foodIconInfo.value.purchaseDate = registerDate
        viewModel.foodIconInfo.value.expirationDate = expirationDate
        viewModel.foodIconInfo.value.count = count
        
//        print("desc: \(mainView.foodDescriptionTextField.text)")
//        print("regi: \(mainView.registerDateTextField.text)")
//        print("exp: \(mainView.expirationDateTextField.text)")
//        print("cnt: \(mainView.countTextField.text)")
//        print("end: \(viewModel.foodIconInfo.value)")
    }
}
