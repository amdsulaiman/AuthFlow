//
//  UIViewController+Alerts.swift.swift
//  AuthFlow
//
//  Created by Mohammed Sulaiman on 17/10/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
