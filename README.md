# AuthFlow

A simple iOS app demonstrating login, session persistence, and logout using **UIKit**.

---

## Features
- Login screen → navigates to Dashboard  
- Dashboard with a Logout button inside the view  
- Session persistence using `UserDefaults` (token stored until logout)  
- Root view controller switches based on login state  

---

## Folder Structure
AuthFlow/
│
├── AppDelegate.swift / SceneDelegate.swift # Root controller setup
├── SessionManager.swift # Handles token storage & login state
├── LoginViewController.swift # Login flow
└── DashboardViewController.swift # Dashboard + Logout button


---

## How to Run
1. Clone or download the project  
2. Open `AuthFlow.xcodeproj` in **Xcode**  
3. Run on simulator or device (`Cmd + R`)  
4. On first launch → Login screen appears  
5. After login → navigates to Dashboard  
6. Tap **Logout** → clears session and returns to Login  

---
