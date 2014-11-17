//
//  PullDownNavigationController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/12/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

//class DiscoverNavigationController: UINavigationController {
//    
//    var window: UIWindow?
//    var navigationBar
//    var isAnimating = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let navigationBar = (self.navigationBar as? DiscoverNavigationBarView)
////        self.navigationBar.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "filterOnPanAction:"))
////        navigationBar!.filterButton.addTarget(self, action: "filterPressedAction", forControlEvents: UIControlEvents.TouchUpInside)
//    }
//    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
//    
//    func openFilter() {
//        if (isAnimating) {
//            retrun
//        }
//        self.navigationBar as? DiscoverNavigationBarView)!.filterButton.hidden = true
//        self.isAnimating = YES;
//        
//        let filterViewController = FilterViewController()
//        self.view.addSubview(filterViewController)
//    }
//    
//    
//    
//    func toggleFilter() {
//        if (self.navigationBar as? DiscoverNavigationBarView)?.filterButton.hidden {
//            closeFilter()
//        } else {
//            openFilter()
//        }
//    }
//}
