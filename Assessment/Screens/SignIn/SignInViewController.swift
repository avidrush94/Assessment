//
//  SignInViewController.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: Self.viewControllerName, bundle: .main)
        
        title = "Sign In"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @IBAction private func signUp(_ sender: UIButton) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func signIn(_ sender: UIButton) {
        guard
            let username = usernameTextField.text,
            let password = passwordTextField.text
        else { return }
        
        do {
            try UserManager.shared.login(username: username, password: password)
            
            let vc = MealListViewController()
            let navVC = UINavigationController(rootViewController: vc)
            set(root: navVC)
        } catch {
            self.alert(message: error.localizedDescription)
        }
    }

}
