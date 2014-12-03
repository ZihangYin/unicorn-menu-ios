//
//  PullDownNavigationController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/12/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import Foundation
import UIKit

class DiscoverNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    var discoverColumnWidth: Float?
    var interactiveTransition: UIViewControllerInteractiveTransitioning?
    
    func navigationController(navigationController: UINavigationController!, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning!{
        switch operation {
        case .Pop:
            if (fromVC.isKindOfClass(DiscoverDetailViewController)) {
                let discoverNavigationTransition = DiscoverNavigationTransition()
                discoverNavigationTransition.presenting = true
                discoverNavigationTransition.animationScale = UIScreen.mainScreen().bounds.size.width / CGFloat(discoverColumnWidth!)
                return discoverNavigationTransition
            } else if (fromVC.isKindOfClass(FilterViewController)) {
                let filterNavigationTransition = MenuTransition()
                filterNavigationTransition.presenting = true
                self.interactiveTransition = nil
                return filterNavigationTransition
            } else if (fromVC.isKindOfClass(MenuViewController)){
                let menuTransition = MenuTransition()
                menuTransition.presenting = true
                return menuTransition
            } else if (fromVC.isKindOfClass(CuisineDetailViewController)) {
                let cuisineDetailTransition = FilterNavigationTransition()
                cuisineDetailTransition.presenting = false
                return cuisineDetailTransition
            } else {
                assertionFailure("non supported navigation transition animation")
            }
        case .Push:
            if (toVC.isKindOfClass(DiscoverDetailViewController)) {
                let discoverNavigationTransition = DiscoverNavigationTransition()
                discoverNavigationTransition.presenting = false
                discoverNavigationTransition.animationScale = UIScreen.mainScreen().bounds.size.width / CGFloat(discoverColumnWidth!)
                self.interactiveTransition = nil
                return discoverNavigationTransition
            } else if (toVC.isKindOfClass(FilterViewController)) {
                let filterNavigationTransition = MenuTransition()
                filterNavigationTransition.presenting = false
                self.interactiveTransition = nil
                return filterNavigationTransition
            } else if (toVC.isKindOfClass(MenuViewController)){
                let menuTransition = MenuTransition()
                menuTransition.presenting = false
                self.interactiveTransition = nil
                return menuTransition
            } else if (toVC.isKindOfClass(CuisineDetailViewController)) {
                let cuisineDetailTransition = FilterNavigationTransition()
                cuisineDetailTransition.presenting = true
                self.interactiveTransition = nil
                
                return cuisineDetailTransition
            } else {
                assertionFailure("non supported navigation transition animation")
            }
        default:
            assertionFailure("non supported navigation transition animation")
            break
        }
    }
    
    func navigationController(navigationController: UINavigationController,
        interactionControllerForAnimationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
            return self.interactiveTransition;
    }
}

class DiscoverNavigationController : UINavigationController {
    var appDelegate: AppDelegate?
    var window: UIWindow?
    
    var firstX = Float()
    var firstY = Float()
    var duration = CGFloat()
    private var origin = CGPoint()
    private var final = CGPoint()
    
    override func viewDidLoad() {
        self.appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        self.window = self.appDelegate!.window
        self.window!.layer.shadowRadius = 1.5
        self.window!.layer.shadowOffset = CGSizeMake(0, 0)
        self.window!.layer.shadowColor = UIColor.blackColor().CGColor
        self.window!.layer.shadowOpacity = 0.8
        
        self.duration = 0.3
    }
    
    func activatePullDownNavigationBar() -> Void {
        var panGesture = UIPanGestureRecognizer(target: self, action: "onPan:")
        self.navigationBar.addGestureRecognizer(panGesture)
    }
    
    func pullDownAndUpNavigationBar() -> Void {
        var finalOrigin = CGPoint()
        var frame: CGRect = self.window!.frame
        
        if (frame.origin.y == CGPointZero.y) {
            UIScreen.mainScreen().bounds
            finalOrigin.y = CGRectGetHeight(UIScreen.mainScreen().bounds) - self.visibleViewController.view.convertPoint(CGPointZero, toView: nil).y
        } else {
            finalOrigin.y = CGPointZero.y
        }
        
        finalOrigin.x = 0
        frame.origin = finalOrigin
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
            self.window!.transform = CGAffineTransformIdentity
            self.window!.frame = frame
            }, completion: nil)
    }
    
    func setAnimationDuration(animationDuration: CGFloat) -> Void {
        self.duration = animationDuration
    }
    
    func onPan(pan: UIPanGestureRecognizer) -> Void {
        var translation: CGPoint = pan.translationInView(self.window!)
        var velocity:CGPoint = pan.velocityInView(self.window!)
        
        switch (pan.state) {
        case .Began:
            self.origin = self.window!.frame.origin
            
        case .Changed:
            if (self.origin.y + translation.y >= 0) {
                self.window!.transform = CGAffineTransformMakeTranslation(0, translation.y)
            }
            
        case .Ended, .Cancelled:
            var finalOrigin = CGPointZero
            if (velocity.y >= 0) {
                finalOrigin.y = CGRectGetHeight(UIScreen.mainScreen().bounds) - self.visibleViewController.view.convertPoint(CGPointZero, toView: nil).y
            }
            
            var frame = self.window!.frame
            frame.origin = finalOrigin
            UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {
                self.window!.transform = CGAffineTransformIdentity
                self.window!.frame = frame
                }, completion: nil)
        default:
            break
        }
    }
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController
    {
        if animated {
            
            let childrenCount = self.viewControllers.count
            //viewWillAppearWithPageIndex
            if let popViewController = self.viewControllers[childrenCount - 1] as? DiscoverDetailViewController {
                let toViewController = self.viewControllers[childrenCount - 2] as DiscoverViewControllerProtocol
                let toView = toViewController.transitionCollectionView()
                let popView  = popViewController.collectionView
                let indexPath = popView.fromIndexPath()
                toViewController.viewWillAppearWithIndex(indexPath.item)
                toView.setToIndexPath(indexPath)
            }
        }
        return super.popViewControllerAnimated(animated)!
    }
}

