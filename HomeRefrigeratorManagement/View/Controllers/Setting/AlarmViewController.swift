//
//  AlarmViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/16.
//

import UIKit


final class AlarmViewController: BaseViewController {
    
    private struct AlarmInfo {
        let title: String
    }
    
    private var list = [
        AlarmInfo(title: "알림 허용")
    ]
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.tableFooterView = self.footerView
        return view
    }()
    
    private lazy var switchView = {
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.addTarget(self, action: #selector(switchViewTapped), for: .valueChanged)
        return switchView
    }()
    
    private let footerView = {
        let view = UIView()
        return view
    }()
    
    private let alarmTimeChoiceLabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.Font.soyoRegular, size: 11)
        label.text = "알림 받을 시간대 선택해주시면 선택한 시간에 알림을 보내드립니다."
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var datePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        picker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        return picker
    }()
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSwitchValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        initialSwitchValue()
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func configureHirarchy() {
        view.addSubview(tableView)
        footerView.addSubview(alarmTimeChoiceLabel)
        footerView.addSubview(datePicker)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alarmTimeChoiceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(alarmTimeChoiceLabel.snp.top)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func switchViewTapped() {
        print(#function)
        if switchView.isOn {
            print(true)
            
            showAlertAction2(
                preferredStyle: .alert,
                title: "알림 허용",
                message: "알림을 사용할 수 없습니다. 기기의 '설정>앱>알림'에서 알림 허용을 해주세요",
                cancelTitle: "취소",
                completeTitle: "확인") {} _: {
                    if !self.checkAccessAlarm() {
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                        
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            
        } else {
            print(false)
        }
    }
    
    private func initialSwitchValue() {
        let result = checkAccessAlarm()
        switchView.setOn(result, animated: true)
    }
    
    private func checkAccessAlarm() -> Bool {
        let permissionStatus = UserDefaults.standard.bool(forKey: "permission")
        print("permissionStatus: \(permissionStatus)")
        return permissionStatus
    }
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switchView.tag = indexPath.row
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryView = switchView
        var content = cell.defaultContentConfiguration()
        
        let data = list[indexPath.row]
        
        content.attributedText = data.title.makeNSAttributedString(fontName: Constant.Font.soyoBold, fontSize: 15)
        content.secondaryAttributedText = "유통기한이 임박한 상품에 대한 알림을 보내드립니다.".makeNSAttributedString(fontName: Constant.Font.soyoRegular, fontSize: 11)
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }

}

