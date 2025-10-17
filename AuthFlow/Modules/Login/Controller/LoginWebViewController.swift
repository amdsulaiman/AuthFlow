//
//  LoginWebViewController.swift
//  AuthFlow
//
//  Created by Mohammed Sulaiman on 17/10/25.
//
import UIKit
import WebKit

final class LoginWebViewController: UIViewController {
    
    private var webView: WKWebView!
    var onLoginResult: ((Result<(String, Bool), Error>) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadOAuthPlayground()
    }
    
    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadOAuthPlayground() {
        guard let url = URL(string: Constants.googleLoginURL) else { return }
        webView.load(URLRequest(url: url))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let fakeRedirect = Constants.appLoginURL
            if let url = URL(string: fakeRedirect) {
                self.handleRedirect(url)
            }
        }
    }
    
    private func handleRedirect(_ url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var token: String?
        var isNewUser = false
        var error: String?
        
        components?.queryItems?.forEach { item in
            if item.name == "token" { token = item.value }
            if item.name == "isNewUser", item.value == "true" { isNewUser = true }
            if item.name == "error" { error = item.value }
        }
        
        if let error = error {
            onLoginResult?(.failure(LoginError.serverError(error)))
        } else if let token = token {
            onLoginResult?(.success((token, isNewUser)))
        } else {
            onLoginResult?(.failure(LoginError.missingToken))
        }
        
        dismiss(animated: true)
    }
}

extension LoginWebViewController: WKNavigationDelegate {}
