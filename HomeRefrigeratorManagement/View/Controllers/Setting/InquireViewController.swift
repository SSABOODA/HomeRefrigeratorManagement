//
//  InquireViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/16.
//

import UIKit
import MessageUI

final class InquireViewController: BaseViewController, MFMailComposeViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        sendEmail()
        navigationItem.largeTitleDisplayMode = .never
    }

    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = self
            
            let bodyString = """
                                 냉싸부 앱을 사용하시다 문제가 있거나 개선 사항이 있다면 말씀해주세요. :)
                                 
                                 이곳에 내용을 작성해주세요.
                                 
                                 
                                 -------------------
                                 
                                 Device Model : \(self.getDeviceIdentifier())
                                 Device OS : \(UIDevice.current.systemVersion)
                                 App Version : \(self.getCurrentVersion())
                                 
                                 -------------------
                                 """
            
            composeViewController.setToRecipients(["ssaboo92@gmail.com"])
            composeViewController.setSubject("<냉싸부> 문의 및 의견")
            composeViewController.setMessageBody(bodyString, isHTML: false)
            
            self.present(composeViewController, animated: true, completion: nil)
        } else {
            print("메일 보내기 실패")
            goAppstoreShowSendMailErrorAlert()
        }
    }
    
    private func goAppstoreShowSendMailErrorAlert() {
        
        let message = """
        메일을 보내려면 다음 2가지 방법 중 하나를 선택해주세요 \n
        1. 메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.
        2. 시스템 설정 -> Mail -> 기본 메일 앱 설정
        """
        
        let sendMailErrorAlert = UIAlertController(
            title: "메일 전송 실패",
            message: message,
            preferredStyle: .alert
        )
        let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
            // 앱스토어로 이동하기(Mail)
            if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                self.navigationController?.popViewController(animated: true)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        sendMailErrorAlert.addAction(goAppStoreAction)
        sendMailErrorAlert.addAction(cancelAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    private func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            (action) in
            self.navigationController?.popViewController(animated: true)
        }
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // Device Identifier 찾기
    private func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    // 현재 버전 가져오기
    private func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            self.dismiss(animated: true, completion: nil)
        case .saved:
            print("")
        case .sent:
            print("")
        case .failed:
            print("")
        @unknown default:
            print(error?.localizedDescription)
        }
        dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }

}
