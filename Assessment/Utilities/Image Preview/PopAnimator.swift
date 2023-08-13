//
//  PopAnimator.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.25
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = presenting ? toView : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : UIScreen.main.bounds
        let finalFrame = presenting ? UIScreen.main.bounds : originFrame
        
        if presenting {
            fromView.alpha = 0
            fromView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY
            )
            let widthRatio = initialFrame.width / finalFrame.width
            let heightRatio = initialFrame.height / finalFrame.height
            fromView.transform = .init(scaleX: widthRatio, y: heightRatio)
            fromView.clipsToBounds = true
        }
        fromView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(fromView)
        
        if self.presenting {
            
            UIView.animate(withDuration: duration, delay: 0) {
                fromView.alpha = 1
                fromView.transform = .identity
                fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                
                transitionContext.view(forKey: .from)?.alpha = 0
            } completion: { success in
                if success {
                    if !self.presenting {
                        self.dismissCompletion?()
                    }
                    transitionContext.completeTransition(true)
                }
            }
            
        } else {
            
            let ratio = finalFrame.width / initialFrame.width
            UIView.animate(withDuration: duration, delay: 0) {
                fromView.alpha = 0
                fromView.transform = .init(scaleX: ratio,
                                           y: ratio)
                fromView.center = CGPoint(x: self.originFrame.midX, y: self.originFrame.midY)
                
                transitionContext.view(forKey: .to)?.alpha = 1
            } completion: { success in
                if success {
                    if !self.presenting {
                        self.dismissCompletion?()
                    }
                    transitionContext.completeTransition(true)
                }
            }
            
        }
    }
}
