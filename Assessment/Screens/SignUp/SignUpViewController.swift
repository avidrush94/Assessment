//
//  SignUpViewController.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: Self.viewControllerName, bundle: .main)
        
        title = "Sign Up"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @IBAction private func signUp(_ sender: UIButton) {
        guard
            let name = nameTextField.text,
            !name.isEmpty
        else {
            self.alert(message: "The name cannot be empty!")
            return
        }
        
        guard
            let username = usernameTextField.text,
            username.count >= 6
        else {
            self.alert(message: "Username should be at least 6 charcaters")
            return
        }
        
        guard
            let password = passwordTextField.text,
            password.count >= 8
        else {
            self.alert(message: "Password should be at least 8 characters")
            return
        }
        
        do {
            try UserManager.shared.register(name: name, username: username, password: password)
            self.alert(message: "New user registered successfully.") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        } catch {
            self.alert(message: error.localizedDescription)
            return
        }
    }
    
}
