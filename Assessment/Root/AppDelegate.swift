//
//  AppDelegate.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

// MARK: - Application Delegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        setupWindow()
        
        return true
    }

}

// MARK: - Window Configurations
extension AppDelegate {
    
    /// Sets the root `window` and the `rootViewController` when the app opens
    private func setupWindow() {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        defer {
            self.window = window
            self.window?.makeKeyAndVisible()
        }
        
        let vc = UserManager.shared.isLoggedIn ? MealListViewController() : SignInViewController()
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        
    }
    
}
