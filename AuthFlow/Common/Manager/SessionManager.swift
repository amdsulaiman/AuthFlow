//
//  SessionManager.swift
//  AuthFlow
//
//  Created by Mohammed Sulaiman on 17/10/25.
//

import Foundation

final class SessionManager {
    static let shared = SessionManager()
    private let tokenKey = "userAuthToken"
    
    var token: String? {
        get { UserDefaults.standard.string(forKey: tokenKey) }
        set {
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: tokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: tokenKey)
            }
        }
    }
    
    var isLoggedIn: Bool {
        return token != nil
    }
    
    func logout() {
        token = nil
    }
}
