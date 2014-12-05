//
//  SlideAnimationTransition.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/4/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit
import QuartzCore

class SlideAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
   
    var duration = 0.25
    var presenting = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let containerView = transitionContext.containerView()
        
        if presenting {
            let width: CGFloat = containerView.frame.size.width
            var offsetRight = fromViewController.view.frame
            offsetRight.origin.x = width
        
            var offscreenLeft = toViewController.view.frame
            offscreenLeft.origin.x = -width/4
            toViewController.view.frame = offscreenLeft;
            toViewController.view.layer.opacity = 0.7
        
            fromViewController.view.layer.shadowPath = UIBezierPath(rect: fromViewController.view.bounds).CGPath
            fromViewController.view.layer.shadowRadius = 7
            fromViewController.view.layer.shadowOpacity = 0.7
            fromViewController.view.layer.masksToBounds = false
        
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
            UIView.animateWithDuration(self.duration, delay: 0, options: .CurveEaseIn, animations: {
                toViewController.view.frame = fromViewController.view.frame
                toViewController.view.layer.opacity = 1
                fromViewController.view.frame = offsetRight
            
                }, completion:{(Bool) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        } else {
            let width: CGFloat = containerView.frame.size.width
            var offsetLeft = fromViewController.view.frame
            offsetLeft.origin.x = -width/4
            fromViewController.view.layer.opacity = 1.0
            
            var offscreenRigth = toViewController.view.frame
            offscreenRigth.origin.x = width
            toViewController.view.frame = offscreenRigth;
            
            containerView.addSubview(toViewController.view)
            
            UIView.animateWithDuration(self.duration, delay: 0, options: .CurveEaseOut, animations: {
                toViewController.view.frame = fromViewController.view.frame
                fromViewController.view.layer.opacity = 0.7
                fromViewController.view.frame = offsetLeft
                
                }, completion:{(Bool) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
    }
}
