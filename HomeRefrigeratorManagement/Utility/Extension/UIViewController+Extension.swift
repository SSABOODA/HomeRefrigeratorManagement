//
//  UIViewController+Extension.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit

extension UIViewController {
    // topbarHeight
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }

    // MARK: - view transition

    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFullNavigation
        case push
    }
    
    func transition<T: UIViewController>(viewController: T, style: TransitionStyle) {
        let vc = viewController
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - navigation

    func setNavigationBar() {
        print(#function)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constant.BaseColor.backgroundColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // MARK: - alert

    func showAlertAction1(
        preferredStyle: UIAlertController.Style = .alert,
        title: String = "",
        message: String = "",
        completeTitle: String = "확인", _ completeHandler:(() -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            
            let completeAction = UIAlertAction(title: completeTitle, style: .default) { action in
                completeHandler?()
            }
            
            alert.addAction(completeAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func showAlertAction2(
        preferredStyle: UIAlertController.Style = .alert,
        title: String = "",
        message: String = "",
        cancelTitle: String = "취소",
        completeTitle: String = "확인",  _ cancelHandler: (() -> Void)? = nil, _ completeHandler: (() -> Void)? = nil) {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
                
                let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                    cancelHandler?()
                }
                
                let completeAction = UIAlertAction(title: completeTitle, style: .destructive) { action in
                    completeHandler?()
                }
                
                alert.addAction(cancelAction)
                alert.addAction(completeAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    
    // UIActivityViewController
    func showActivityVC(
        activityItems: [Any],
        applicationActivities: [UIActivity],
        completion: (() -> ())? = nil) {
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
            
            activityViewController.popoverPresentationController?.sourceView = self.view
            //        activityVC.excludedActivityTypes = [.postToTwitter, .postToWeibo, .postToVimeo, .postToFlickr, .postToFacebook, .postToTencentWeibo]
            
            activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
                if success {
                    // 성공했을 때 작업
                    completion?()
                }  else  {
                    // 실패했을 때 작업
                    completion?()
                }
            }
            
            present(activityViewController, animated: true, completion: completion)
        }
    
    // 네비게이션 폰트 변경
    func changeNavigationCustomFont() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constant.Font.soyoBold, size: Constant.FontSize.navigationLargeTitleFontSize)!]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constant.Font.soyoBold, size: 15)!]
    }
    
    // 텍스트필드 제약
    func foodInputDataTextFieldRestriction(_ textField: UITextField, string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        
        if textField.tag == 0 {
            print("tag 0", textField.text!.count)
            guard textField.text!.count < 19 else { return false } // 100 글자로 제한
        } else if textField.tag == 1 {
            print("tag 1")
            if textField.isEditing {
                print("textField: \(textField)")
            }
            if let text = textField.text,
               let amount = Int(text),
               (0 < amount), (amount < 100) {
                return true
            } else {
                if let text = textField.text {
                    if text.isEmpty {
                        return true
                    }
                }
            }
            return false
        }
        return true
    }
}
