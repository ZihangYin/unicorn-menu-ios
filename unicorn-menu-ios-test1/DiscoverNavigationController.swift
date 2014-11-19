//
//  PullDownNavigationController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/12/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import Foundation
import UIKit

class DiscoverNavigationController : UINavigationController {
    override func popViewControllerAnimated(animated: Bool) -> UIViewController
    {
        //viewWillAppearWithPageIndex
        let childrenCount = self.viewControllers.count
        let toViewController = self.viewControllers[childrenCount - 2] as DiscoverViewControllerProtocol
        let toView = toViewController.transitionCollectionView()
        let popedViewController = self.viewControllers[childrenCount - 1] as UICollectionViewController
        let popView  = popedViewController.collectionView
        let indexPath = popView.currentIndexPath()
        toViewController.viewWillAppearWithIndex(indexPath.row)
        toView.setCurrentIndexPath(popView.currentIndexPath())
        return super.popViewControllerAnimated(animated)!
    }
}

