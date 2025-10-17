//
//  LoginError.swift
//  AuthFlow
//
//  Created by Mohammed Sulaiman on 17/10/25.
//

import Foundation

enum LoginError: LocalizedError {
    case invalidURL
    case missingToken
    case serverError(String)
    case newUser
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid login URL."
        case .missingToken:
            return "Login token not found."
        case .serverError(let message):
            return "Login failed: \(message)"
        case .newUser:
            return "User does not exist. Please create an account."
        }
    }
}
