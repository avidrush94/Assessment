//
//  ImagePreviewVC.swift
//  Take Flight
//
//  Created by Rushit on 13/08/23.
//

import UIKit
import Kingfisher

class ImagePreviewVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    private let transition = PopAnimator()
    
    private let imageURL: URL?
    private let sourceFrame: CGRect?
    
    // MARK: - Outlets
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    // MARK: - Lifecycle
    
    init(url: URL, sourceFrame: CGRect? = nil) {
        self.imageURL = url
        self.sourceFrame = sourceFrame
        super.init(nibName: Self.viewControllerName, bundle: .main)
        
        modalPresentationStyle = .fullScreen
        transitioningDelegate = sourceFrame == nil ? nil : self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = imageURL {
            activityIndicator.startAnimating()
            imageView.kf.setImage(with: url) { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            }
        }
        
        addTapToResetZoom()
        
    }
    
    // MARK: - Actions
    
    @IBAction
    private func dismiss(sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - Functionalities
    
    private func addTapToResetZoom() {
        let doubleTapGesture = UITapGestureRecognizer()
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.addTarget(self, action: #selector(resetZoom))
        scrollView.addGestureRecognizer(doubleTapGesture)
    }
    
    // MARK: - Scroll Delegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    @objc func resetZoom() {
        scrollView.setZoomScale(1, animated: true)
    }

}

// MARK: - Transitioning Delegate
extension ImagePreviewVC: UIViewControllerTransitioningDelegate {
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = sourceFrame!
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}


