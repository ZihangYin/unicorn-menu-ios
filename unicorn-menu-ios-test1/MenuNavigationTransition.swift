//
//  MenuNavigationTransition.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/22/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit
import Foundation

class MenuNavigationTransition: NSObject, UIViewControllerAnimatedTransitioning {
   
    var duration = 0.35
    var rotateAngle = M_PI_4
    var relativeDelayLeftView = 0.09
    var relativeDelayRightView = 0.12
    var presenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let containerView = transitionContext.containerView()
        
        toViewController.view.layer.zPosition = fromViewController.view.layer.zPosition + 1;
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width;
        
        var leftViewTransfrom = CATransform3DIdentity;
        leftViewTransfrom.m34 = 1.0 / -500;
        leftViewTransfrom = CATransform3DRotate(leftViewTransfrom, CGFloat(self.rotateAngle), 0, 1, 0);
        leftViewTransfrom = CATransform3DTranslate(leftViewTransfrom, -screenWidth/2, 0, -screenWidth/2);
        
        var rightViewTransfrom = CATransform3DIdentity;
        rightViewTransfrom.m34 = 1.0 / -500;
        rightViewTransfrom = CATransform3DTranslate(rightViewTransfrom, screenWidth, 0, 0);
        rightViewTransfrom = CATransform3DTranslate(rightViewTransfrom, -screenWidth/2, 0, 0);
        rightViewTransfrom = CATransform3DRotate(rightViewTransfrom, -CGFloat(self.rotateAngle), 0, 1, 0);
        rightViewTransfrom = CATransform3DTranslate(rightViewTransfrom, screenWidth/2, 0, 0);
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        if presenting {
            
            toViewController.view.layer.transform = rightViewTransfrom;
            fromViewController.view.alpha = 1;
            
            UIView.animateKeyframesWithDuration(self.duration, delay: 0.0, options: .LayoutSubviews, animations: {
                fromViewController.view.layer.transform = leftViewTransfrom;
                fromViewController.view.alpha = 0;
                UIView.addKeyframeWithRelativeStartTime(self.relativeDelayLeftView/self.duration, relativeDuration: 1 - self.relativeDelayLeftView / self.duration, animations: {
                    toViewController.view.layer.transform = CATransform3DIdentity;
                    })
                }, completion:{(Bool) in
                    if transitionContext.transitionWasCancelled() {
                        transitionContext.completeTransition(false)
                    } else {
                        transitionContext.completeTransition(true)
                    }
            })
        } else {
            toViewController.view.layer.transform = leftViewTransfrom;
            toViewController.view.alpha = 0;
            
            UIView.animateKeyframesWithDuration(self.duration, delay: 0.0, options: .LayoutSubviews, animations: {
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: {
                    fromViewController.view.layer.transform = rightViewTransfrom
                })
                UIView.addKeyframeWithRelativeStartTime(self.relativeDelayRightView / self.duration, relativeDuration: 1 - self.relativeDelayRightView / self.duration, animations: {
                    toViewController.view.layer.transform = CATransform3DIdentity
                })
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.85, animations: {
                    toViewController.view.alpha = 0.5
                })
                UIView.addKeyframeWithRelativeStartTime(0.85, relativeDuration: 0.15, animations: {
                    toViewController.view.alpha = 1
                })
                }, completion:{(Bool) in
                    if transitionContext.transitionWasCancelled() {
                        transitionContext.completeTransition(false)
                    } else {
                        transitionContext.completeTransition(true)
                    }
            })   
        }
        
    }
}

