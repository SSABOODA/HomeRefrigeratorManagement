//
//  PrivacyViewController.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/19.
//

import Foundation
import WebKit

final class PrivacyViewController: BaseViewController, WKUIDelegate {
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        privateWebView()
        configureNavigationBar()
     }
    
    override func configureHirarchy() {
        view.addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        // 네비게이션
        let appearance = UINavigationBarAppearance()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func privateWebView() {
        let notionPrivacyURL = Constant.URLString.privacyNotionURL
        let myURL = URL(string: notionPrivacyURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
