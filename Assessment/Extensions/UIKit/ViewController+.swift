//
//  ViewController+.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

extension UIViewController {
    
    /// use this variable in `init(nibName:, bundle:)`
    class var viewControllerName: String { String(describing: self) }
    
}

// MARK: - App Root
extension UIViewController {
    
    /// Use this fuction to replace the `rootViewController` for the current `window` of the app.
    /// This functions gives a "fade" animation when replacing the `rootViewController`
    ///
    /// - Parameters:
    ///   - viewController: the new `UIViewController` to be shown
    ///   - completion: any code to be executed after the transition to new viewController has completed
    internal func set(root viewController: UIViewController, completion: (() -> Void)? = nil) {

        let animationTime: TimeInterval = 0.3

        guard
            let applicationDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                fatalError("Cast to AppDelegate failed")
        }
        
        let animations: () -> Void = {
            applicationDelegate.window?.rootViewController?.view.alpha = 0
        }
        
        let onAnimationCompletion: ((Bool) -> Void)? = { completed in
            if completed {
                applicationDelegate.window?.subviews.forEach { $0.removeFromSuperview() }
                applicationDelegate.window?.rootViewController = nil
                viewController.view.alpha = 0
                applicationDelegate.window?.rootViewController = viewController
                applicationDelegate.window?.makeKeyAndVisible()
                
                let animations: () -> Void = {
                    viewController.view.alpha = 1
                }
                
                let onAnimationCompletion: ((Bool) -> Void)? = { success in
                    if success {
                        completion?()
                    }
                }

                UIView.animate(
                    withDuration: animationTime / 2,
                    animations: animations,
                    completion: onAnimationCompletion
                )

            }
        }

        UIView.animate(
            withDuration: animationTime / 2,
            animations: animations,
            completion: onAnimationCompletion
        )

    }
    
}

// MARK: - Alerts
extension UIViewController {
    
    func alert(
        title: String = "Alert",
        message: String,
        onDismiss: (() -> Void)? = nil
    ) {

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: { _ in onDismiss?() }
            )
        )
        present(alert, animated: true)

    }
    
}
