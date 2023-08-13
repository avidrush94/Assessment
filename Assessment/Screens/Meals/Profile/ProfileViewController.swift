//
//  ProfileViewController.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var usernameLabel: UILabel!

    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: Self.viewControllerName, bundle: .main)
        
        title = "Profile"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
    }
    
    // MARK: - Actions
    
    @IBAction private func logout(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Logout",
            message: "Do you want to logout and close this seesion?",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Logout",
                style: .destructive
            ) { _ in
                UserManager.shared.logout()
                let vc = SignInViewController()
                let navVC = UINavigationController(rootViewController: vc)
                self.set(root: navVC)
            }
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // MARK: - Functionalitites
    
    private func configureLabels() {
        nameLabel.text = UserManager.shared.currentUser?.name
        usernameLabel.text = UserManager.shared.currentUser?.readableUsername
    }
    
}
