//
//  DiscoverNavigationTransition.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@objc protocol DiscoverNavigationTransitionProtocol{
    func transitionCollectionView() -> UICollectionView!
}

class DiscoverNavigationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var presenting = false
    var animationDuration = 1.0
    var animationScale: CGFloat = 1.0
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval{
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let containerView = transitionContext.containerView()
        
        if presenting {
            let fromView = fromViewController.view
            let toView = toViewController.view
            containerView.addSubview(toView)
            toView.hidden = true
            
            let discoverView = (toViewController as DiscoverNavigationTransitionProtocol).transitionCollectionView()
            let discoverDetailView = (fromViewController as DiscoverNavigationTransitionProtocol).transitionCollectionView()
            
            discoverView.layoutIfNeeded()
            let indexPath = discoverDetailView.currentIndexPath()
            let discoverDetailCellView = discoverView.cellForItemAtIndexPath(indexPath)
            var leftUpperPoint = discoverDetailCellView!.convertPoint(CGPointZero, toView: containerView)
            
            let snapShot = (discoverDetailCellView as DiscoverTansitionViewCellProtocol).snapShotForDiscoverTransition()
            leftUpperPoint.x += snapShot.frame.origin.x
            leftUpperPoint.y += snapShot.frame.origin.y
            
            snapShot.transform = CGAffineTransformMakeScale(self.animationScale, self.animationScale)
            snapShot.frame.origin.x = 0
            snapShot.frame.origin.y = -(fromViewController as DiscoverDetailViewControllerProtocol).detailViewCellScrollViewContentOffset().y + fromView.frame.origin.y
            containerView.addSubview(snapShot)
            
            toView.hidden = false
            toView.alpha = 0
            toView.transform = snapShot.transform
            let backgroundViewContainer = UIView(frame: UIScreen.mainScreen().bounds)
            backgroundViewContainer.backgroundColor = UIColor.darkGrayColor()
            containerView.addSubview(snapShot)
            containerView.insertSubview(backgroundViewContainer, belowSubview: toView)
            
            UIView.animateWithDuration(self.animationDuration, delay: 0, options: .CurveEaseInOut, animations: {
                snapShot.transform = CGAffineTransformIdentity
                snapShot.frame = CGRectMake(leftUpperPoint.x, leftUpperPoint.y, snapShot.frame.size.width, snapShot.frame.size.height)
                toView.transform = CGAffineTransformIdentity
                toView.alpha = 1
                }, completion:{finished in
                    if finished {
                        snapShot.removeFromSuperview()
                        backgroundViewContainer.removeFromSuperview()
                        transitionContext.completeTransition(true)
                    }
            })
        } else {
            let fromView = fromViewController.view
            let toView = toViewController.view
            
            let discoverView = (fromViewController as DiscoverNavigationTransitionProtocol).transitionCollectionView()
            let discoverDetailView : UICollectionView = (toViewController as DiscoverNavigationTransitionProtocol).transitionCollectionView()
            
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
            
            let indexPath = discoverView.currentIndexPath()
            let discoverCellView = discoverView.cellForItemAtIndexPath(indexPath)
            
            let leftUpperPoint = discoverCellView!.convertPoint(CGPointZero, toView: containerView)
            discoverDetailView.hidden = true
            discoverDetailView.scrollToItemAtIndexPath(indexPath, atScrollPosition:.CenteredHorizontally, animated: false)
            
            let snapShot = (discoverCellView as DiscoverTansitionViewCellProtocol).snapShotForDiscoverTransition()
            snapShot.frame.origin.x += leftUpperPoint.x
            snapShot.frame.origin.y += leftUpperPoint.y
            let backgroundViewContainer = UIView(frame: UIScreen.mainScreen().bounds)
            backgroundViewContainer.backgroundColor = UIColor.darkGrayColor()
            containerView.addSubview(snapShot)
            containerView.insertSubview(backgroundViewContainer, belowSubview: fromView)

            UIView.animateWithDuration(self.animationDuration, delay: 0, options: .CurveEaseInOut, animations: {
                snapShot.transform = CGAffineTransformMakeScale(self.animationScale, self.animationScale)
                snapShot.frame = CGRectMake(0, toView.frame.origin.y, snapShot.frame.size.width, snapShot.frame.size.height)
                fromView.alpha = 0
                fromView.transform = snapShot.transform
                },completion:{finished in
                    if finished {
                        snapShot.removeFromSuperview()
                        discoverDetailView.hidden = false
                        fromView.transform = CGAffineTransformIdentity
                        backgroundViewContainer.removeFromSuperview()
                        transitionContext.completeTransition(true)

                    }
            })
        }
    }
}
