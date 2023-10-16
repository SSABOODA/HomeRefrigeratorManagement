//
//  AlarmViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/16.
//

import UIKit

final class AlarmViewController: BaseViewController {
    
    struct AlarmInfo {
        let title: String
    }
    
    var list = [
        AlarmInfo(title: "알림 허용")
    ]
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var switchView = {
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.addTarget(self, action: #selector(switchViewTapped), for: .valueChanged)
        return switchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAccessAlarm()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func configureHirarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func switchViewTapped() {
        print(#function)
    }
    
    private func checkAccessAlarm() {
        let permissionStatus = UserDefaults.standard.bool(forKey: "permission")
        print("permissionStatus: \(permissionStatus)")
        switchView.setOn(permissionStatus, animated: true)
    }
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switchView.tag = indexPath.row
        let cell = UITableViewCell()
        cell.accessoryView = switchView
        var content = cell.defaultContentConfiguration()
        
        let data = list[indexPath.row]
        
        content.attributedText = data.title.makeNSAttributedString(fontName: Constant.Font.soyoBold, fontSize: 15)
        content.secondaryAttributedText = "유통기한이 임박한 상품에 대한 알림을 보내드립니다.".makeNSAttributedString(fontName: Constant.Font.soyoRegular, fontSize: 11)
        cell.contentConfiguration = content
        return cell
    }
    
}
