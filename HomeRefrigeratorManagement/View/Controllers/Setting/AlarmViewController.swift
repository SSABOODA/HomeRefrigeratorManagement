//
//  AlarmViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/16.
//

import UIKit
import Toast


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

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        initialSwitch()
        inititalDatePickerSetTime()
        startAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
    
    private func initialSwitch() {
        UserNotificationRepository.shared.checkPermission { [weak self] value in
            if !value {
                self?.setSwitchValue(UserDefaultsHelper.standard.permission)
            } else {
                self?.setSwitchValue(UserDefaultsHelper.standard.switchValue)
            }
        }
    }
    
    private func inititalDatePickerSetTime() {

        let selectedHour = UserDefaultsHelper.standard.hour
        let selectedMinute = UserDefaultsHelper.standard.minute
        
        let calendar = Calendar.current
        var components = DateComponents()
        components.hour = selectedHour
        components.minute = selectedMinute
            
        datePicker.setDate(calendar.date(from: components)!, animated: true)
        
    }
    
    private func startAddObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkNotificationSetting),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: sender.date)
        let hour = timeComponents.hour ?? 0
        let minute = timeComponents.minute ?? 0
        
        if (hour != UserDefaultsHelper.standard.hour) || (minute != UserDefaultsHelper.standard.minute) {
            UserDefaultsHelper.standard.isManual = true
            UserDefaultsHelper.standard.hour = hour
            UserDefaultsHelper.standard.minute = minute
            UserNotificationRepository.shared.removePendingNotificationRequests()
            UserNotificationRepository.shared.configureUserNotification()
            
            self.view.makeToast("매일 \(hour)시 \(minute)분에 알림을 보내드릴게요.😀")
        }
    }
    
    @objc private func checkNotificationSetting(notification: NSNotification) {
        UserNotificationRepository.shared.checkPermission { [weak self] value in
            if !value {
                self?.setSwitchValue(UserDefaultsHelper.standard.permission)
            }
        }
    }
    
    @objc func switchViewTapped() {

        if switchView.isOn {
            
            UserDefaultsHelper.standard.switchValue = true
            
            if !UserDefaultsHelper.standard.permission {
                // 시스템 설정 Off
                showAlertAction2(
                    preferredStyle: .alert,
                    title: "알림 허용",
                    message: "알림을 사용할 수 없습니다. 기기의 '설정>앱>알림'에서 알림 허용을 해주세요",
                    cancelTitle: "취소",
                    completeTitle: "확인") {
                        self.setSwitchValue(false)
                    } _: {
                        if !self.checkAccessAlarm() {
                            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                            
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }
                        self.footerView.isHidden = false
                    }
            } else {
                // 시스템 설정 On
                self.setSwitchValue(true)
                UserNotificationRepository.shared.configureUserNotification()
            }
            
        } else {
            footerView.isHidden = true
            UserDefaultsHelper.standard.switchValue = false
            UserNotificationRepository.shared.removePendingNotificationRequests()
        }
    }
    
    private func setSwitchValue(_ permission: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            if permission {
                self?.switchView.setOn(permission, animated: true)
                self?.footerView.isHidden = !permission
            } else {
                self?.switchView.setOn(permission, animated: true)
                self?.footerView.isHidden = !permission
            }
        }
    }
    
    private func checkAccessAlarm() -> Bool {
        let permissionStatus = UserDefaultsHelper.standard.permission
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

