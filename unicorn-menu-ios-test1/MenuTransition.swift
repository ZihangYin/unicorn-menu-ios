//
//  PullDownTransition.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/25/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class MenuTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var presentingDuration = 0.45
    var nonPresentingDuration = 0.7
    var presenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        if presenting {
            return self.presentingDuration
        } else {
            return self.nonPresentingDuration
        }
    }
    
     func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let containerView = transitionContext.containerView()
        
        containerView.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        if presenting {
            containerView.addSubview(toViewController.view)
            containerView.addSubview(fromViewController.view)
            
            UIView.animateWithDuration(self.presentingDuration, delay: 0.0, options: .CurveEaseInOut, animations: {
                fromViewController.view.transform = CGAffineTransformMakeTranslation(0, toViewController.view.frame.size.height)
                fromViewController.view.alpha = 0
                toViewController.view.alpha = 1
                }, completion:{(Bool) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        } else {
            containerView.addSubview(toViewController.view)
            toViewController.view.transform = CGAffineTransformMakeTranslation(0, -toViewController.view.frame.size.height)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(self.nonPresentingDuration, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
                fromViewController.view.alpha = 0
                toViewController.view.alpha = 1
                toViewController.view.transform = CGAffineTransformIdentity
                }, completion:{(Bool) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
    }
}