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
        
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
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
//        dismiss(animated: true)
        view.endEditing(true)
    }
    
    @objc func dateTextFieldTapped(_ sender: UITextField) {
        print(#function)
        
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
    
    @objc func dateChange(_ sender: UIDatePicker) {
        viewModel.registerDate.value = dateFormat(date: sender.date)
        print("viewModel.registerDate.value: \(viewModel.registerDate.value)")
        
//        mainView.registerDateTextField.text = dateFormat(date: sender.date)
//        mainView.expirationDateTextField.text = dateFormat(date: sender.date)
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    @objc func cancelButtonTapped() {
        print(#function)
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        print(#function)
    }
    
}
