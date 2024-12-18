//
//  YoutubeWebViewViewController.swift

import UIKit
import WebKit
import SnapKit
import RxSwift

final class YoutubeWebViewViewController: BaseViewController {
    
    let webView = WKWebView()
    let toolbar = UIToolbar(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 80)
        )
    )
    
    var foodDataName: String = ""
    var webViewURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        setNav()
        setToolbar()
    }
    
    override func configureView() {
        view.addSubview(webView)
        view.addSubview(toolbar)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-toolbar.frame.height)
        }
        
        toolbar.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let query = "\(removeDirectInputString(foodDataName)) 레시피".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let query else { return }
        webViewURL = URL(string: Constant.URLString.youtubeURL + "=\(query)")
        guard let url = webViewURL else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    private func removeDirectInputString(_ foodDataName: String) -> String {
        guard let name = foodDataName.split(separator: "-").first else { return "" }
        return String(name)
    }
    
    private func setNav() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constant.BaseColor.backgroundColor?.withAlphaComponent(0.8)
        
        // 투명도
        navigationController?.navigationBar.isTranslucent = false
        // scrollEdgeAppearance: 시작부터 적용 -> 스크롤하면 없어짐
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        title = Constant.NavigationTitle.youtubeWebViewTitle
        
        // barButton
        let leftbarButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(leftbarButtonTapped))
        navigationItem.leftBarButtonItem = leftbarButton
        
    }
    
    private func setToolbar() {
        toolbar.backgroundColor = .white.withAlphaComponent(0.8)
        var items: [UIBarButtonItem] = []

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        let backActionToolbarButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backActionToolbarButtonTapped)
        )
        let forwardActionToolbarButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.forward"),
            style: .plain, target: self,
            action: #selector(forwardActionToolbarButtonTapped)
        )
        let activityToolbarButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(activityToolbarButtonTapped)
        )
        let refreshToolbarButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshBarButtonTapped)
        )
        
        items.append(backActionToolbarButton)
        items.append(flexibleSpace)
        items.append(forwardActionToolbarButton)
        items.append(flexibleSpace)
        items.append(activityToolbarButton)
        items.append(flexibleSpace)
        items.append(refreshToolbarButton)
        
        items.forEach { (item) in
            item.tintColor = .systemBlue
        }
        
        toolbar.setItems(items, animated: true)
    }
    
    @objc func leftbarButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func refreshBarButtonTapped() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.webView.reload()
            self.webView.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func backActionToolbarButtonTapped() {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
    
    @objc func forwardActionToolbarButtonTapped() {
        if self.webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func activityToolbarButtonTapped() {
        guard let urlToShare: String = webViewURL?.absoluteString else { return }
        let safariActivity = SafariActivity()
        safariActivity.delegate = self
        
        showActivityVC(
            activityItems: [urlToShare],
            applicationActivities: [safariActivity]
        )
    }
}

extension YoutubeWebViewViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
}

extension YoutubeWebViewViewController: CustomActivityDelegate {
    func performActionCompletion(actvity: SafariActivity) {
        guard let url = webViewURL, UIApplication.shared.canOpenURL(url) else { return }
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


