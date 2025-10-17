//
//  LoginViewController.swift
//  AuthFlow
//
//  Created by Mohammed Sulaiman on 17/10/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Google (WebView)", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 280)
        ])
        
        loginButton.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
    }
    
    @objc private func openWebView() {
        let webVC = LoginWebViewController()
        webVC.modalPresentationStyle = .fullScreen
        webVC.onLoginResult = { [weak self] result in
            self?.handleLoginResult(result)
        }
        present(webVC, animated: true)
    }
    
    private func handleLoginResult(_ result: Result<(String, Bool), Error>) {
        switch result {
        case .success((let token, _)):
            print("Token received: \(token)")
            SessionManager.shared.token = token
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController")
            let nav = UINavigationController(rootViewController: dashboardVC)
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }

        case .failure(let error):
            showAlert(title: "Login Failed", message: error.localizedDescription)
        }
    }

    
    private func navigateToCreateAccount() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
