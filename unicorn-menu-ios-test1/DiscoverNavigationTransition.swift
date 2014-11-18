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
    var animationDuration = 0.3
    var animationScale: CGFloat = 1.0
    var statusAndNavigationBarHeight: CGFloat = 64.0
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval{
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let containerView = transitionContext.containerView()
        
        if presenting {
            let toView = toViewController.view
            containerView.addSubview(toView)
            toView.hidden = true
            
            let discoverView = (toViewController as DiscoverNavigationTransitionProtocol).transitionCollectionView()
            let discoverDetailView = (fromViewController as DiscoverNavigationTransitionProtocol).transitionCollectionView()
            
            discoverView.layoutIfNeeded()
            let indexPath = discoverDetailView.currentIndexPath()
            let discoverCellView = discoverView.cellForItemAtIndexPath(indexPath)
            let leftUpperPoint = discoverCellView!.convertPoint(CGPointZero, toView: nil)
            
            let snapShot = (discoverCellView as DiscoverTansitionViewCellProtocol).snapShotForDiscoverTransition()
            println("\(self.animationScale)")
            snapShot.transform = CGAffineTransformMakeScale(self.animationScale, self.animationScale)
            let pullOffsetY = (fromViewController as DiscoverDetailViewControllerProtocol).detailViewCellScrollViewContentOffset().y
            let offsetY : CGFloat = fromViewController.navigationController!.navigationBarHidden ? 0.0 : statusAndNavigationBarHeight + 30
            snapShot.frame.origin.x = 0
            snapShot.frame.origin.y = -pullOffsetY + offsetY
            containerView.addSubview(snapShot)
            
            toView.hidden = false
            toView.alpha = 0
            toView.transform = snapShot.transform
//            toView.removeConstraints(toView.constraints())
//            toView.frame = CGRectMake(-(leftUpperPoint.x * self.animationScale), -((leftUpperPoint.y - offsetY) * self.animationScale + pullOffsetY + offsetY), toView.bounds.size.width, toView.bounds.size.height)
            let whiteViewContainer = UIView(frame: UIScreen.mainScreen().bounds)
            whiteViewContainer.backgroundColor = UIColor.whiteColor()
            containerView.addSubview(snapShot)
            containerView.insertSubview(whiteViewContainer, belowSubview: toView)
            
            UIView.animateWithDuration(self.animationDuration, animations: {
                snapShot.transform = CGAffineTransformIdentity
                snapShot.frame = CGRectMake(leftUpperPoint.x, leftUpperPoint.y, snapShot.frame.size.width, snapShot.frame.size.height)
                toView.transform = CGAffineTransformIdentity
//                toView.frame = CGRectMake(0, 0, toView.bounds.size.width, toView.bounds.size.height);
                toView.alpha = 1
                }, completion:{finished in
                    if finished {
                        snapShot.removeFromSuperview()
                        whiteViewContainer.removeFromSuperview()
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
            
            let leftUpperPoint = discoverCellView!.convertPoint(CGPointZero, toView: nil)
            discoverDetailView.hidden = true
            discoverDetailView.scrollToItemAtIndexPath(indexPath, atScrollPosition:.CenteredHorizontally, animated: false)
            
            let offsetY : CGFloat = fromViewController.navigationController!.navigationBarHidden ? 0.0 : statusAndNavigationBarHeight
            let offsetStatuBar : CGFloat = fromViewController.navigationController!.navigationBarHidden ? 0.0 : 20.0;
            let snapShot = (discoverCellView as DiscoverTansitionViewCellProtocol).snapShotForDiscoverTransition()
            containerView.addSubview(snapShot)
            snapShot.frame.origin.x = leftUpperPoint.x
            snapShot.frame.origin.y = leftUpperPoint.y
            UIView.animateWithDuration(self.animationDuration, animations: {
                snapShot.transform = CGAffineTransformMakeScale(self.animationScale, self.animationScale)
                snapShot.frame = CGRectMake(0, offsetY, snapShot.frame.size.width, snapShot.frame.size.height)
                fromView.alpha = 0
                fromView.transform = snapShot.transform
//                fromView.removeConstraints(fromView.constraints())
//                fromView.frame = CGRectMake(-(leftUpperPoint.x) * self.animationScale,
//                    -(leftUpperPoint.y-offsetStatuBar) * self.animationScale + offsetStatuBar,
//                    fromView.bounds.size.width,
//                    fromView.bounds.size.height)
                },completion:{finished in
                    if finished {
                        snapShot.removeFromSuperview()
                        discoverDetailView.hidden = false
                        fromView.transform = CGAffineTransformIdentity
                        transitionContext.completeTransition(true)

                    }
            })
        }
    }
}
