//
//  UIViewController+Extension.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import UIKit

extension UIViewController {
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

    // 식품 등록, 수정 시 저장 방법을 입력하지 않았을 경우
    func emptyStorageTypeAlert() {
        let alert = UIAlertController(title: "저장 방법을 선택해주세요", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 식품 등록, 수정 시 수량을 입력하지 않았을 경우
    func noInputFoodCountAlert() {
        let alert = UIAlertController(title: "수량을 입력해주세요", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // 식품 정보 삭제 시
    func deleteFoodDataAlert(_ completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    // 식품 정보 업데이트 시
    func updateFoodDataAlert(_ completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "수정하시겠습니까?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

    
}
