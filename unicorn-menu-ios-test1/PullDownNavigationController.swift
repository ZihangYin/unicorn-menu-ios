//
//  PullDownNavigationController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/12/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class PullDownNavigationController: UINavigationController {
    
    var appDelegate: AppDelegate?
    var window: UIWindow?
    var navBar: UINavigationBar?
    
    var firstX = Float()
    var firstY = Float()
    private var origin = CGPoint()
    private var final = CGPoint()
    
    override func viewDidLoad() {
        self.appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        self.window = self.appDelegate!.window
        self.window!.layer.shadowRadius = 1.5
        self.window!.layer.shadowOffset = CGSizeMake(0, 0)
        self.window!.layer.shadowColor = UIColor.blackColor().CGColor
        self.window!.layer.shadowOpacity = 0.8

        self.navigationBarHidden = true
        self.navBar = NavView(frame: CGRectMake(0, self.view.bounds.height - 60, self.view.frame.width, 60))
        self.view.addSubview(navBar!)
 
    }
    
    func activatePullDownNavigationBar() -> Void {
        var panGesture = UIPanGestureRecognizer(target: self, action: "onPan:")
        self.navBar!.addGestureRecognizer(panGesture)
    }
    
    func pullDownNavigationBar() -> Void {
        var finalOrigin = CGPoint()
        var frame: CGRect = self.window!.frame
        
        if (frame.origin.y == CGPointZero.y) {
            finalOrigin.y = CGRectGetHeight(UIScreen.mainScreen().bounds) - (self.navigationBar.frame.height + self.navigationBar.frame.origin.y)
        } else {
            finalOrigin.y = CGPointZero.y
        }
        
        finalOrigin.x = 0
        frame.origin = finalOrigin
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
            self.window!.transform = CGAffineTransformIdentity
            self.window!.frame = frame
            },
            completion: nil)
    }
    
    func onPan(pan: UIPanGestureRecognizer) -> Void {
        var translation: CGPoint = pan.translationInView(self.window!)
        var velocity:CGPoint = pan.velocityInView(self.window!)
        
        switch (pan.state) {
        case .Began:
            self.origin = self.window!.frame.origin
            
        case .Changed:
            if (self.origin.y - translation.y >= 0) {
                self.window!.transform = CGAffineTransformMakeTranslation(0, translation.y)
            }
 
        case .Ended, .Cancelled:
            var finalOrigin = CGPointZero
            if (velocity.y <= 0) {
                finalOrigin.y = -CGRectGetHeight(UIScreen.mainScreen().bounds) + (self.navBar!.frame.height)
            }
            var frame = self.window!.frame
            frame.origin = finalOrigin
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
                self.window!.transform = CGAffineTransformIdentity
                self.window!.frame = frame
                }, completion: nil)
            
        default:
            break
        }
    }
}
