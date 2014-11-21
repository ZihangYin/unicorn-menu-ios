//
//  ViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/7/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DiscoverViewControllerProtocol : DiscoverNavigationTransitionProtocol{
    func viewWillAppearWithIndex(index : NSInteger)
}

class DiscoverNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    var discoverColumnWidth: Float?
    
    func navigationController(navigationController: UINavigationController!, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning!{
        let discoverNavigationTransition = DiscoverNavigationTransition()
        discoverNavigationTransition.presenting = operation == .Pop
        discoverNavigationTransition.animationScale = UIScreen.mainScreen().bounds.size.width / CGFloat(discoverColumnWidth!)
        
        return  discoverNavigationTransition
    }
}

class DiscoverViewController: UICollectionViewController, CollectionViewDelegateWaterfallFlowLayout, UICollectionViewDataSource, DiscoverViewControllerProtocol {
    
    lazy var images: [UIImage] = {
        var _images = [UIImage]()
        for index in 0 ... 9 {
            let imageName = String(format: "FICDDemoImage00%d.jpg", index)
            _images.append(UIImage(named: imageName)!)
        }
        for index in 10 ... 99 {
            let imageName = String(format: "FICDDemoImage0%d.jpg", index)
            _images.append(UIImage(named: imageName)!)
        }
        return _images
    }()
    
    let navigationDelegate = DiscoverNavigationControllerDelegate()
    var columnWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(DiscoverViewCell.self, forCellWithReuseIdentifier: "DiscoverCell")
//        self.collectionView.registerClass(CollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallFlowLayoutElementKindSectionHeader, withReuseIdentifier: "DiscoverHeader")
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.directionalLockEnabled = true
        
        self.navigationController!.delegate = navigationDelegate
        autoLayoutSubviews()
        
        self.collectionView.reloadData()
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: "handleLongPress:")
        self.collectionView.addGestureRecognizer(longPress)
//        let discoverNavigationBar = self.navigationController!.navigationBar as? DiscoverNavigationBarView
//        discoverNavigationBar!.filterButton.addTarget(self, action: "filterPressedAction", forControlEvents: UIControlEvents.TouchUpInside)
//        discoverNavigationBar!.filterButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "filterPressedAction"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.columnWidth = CGFloat((self.collectionViewLayout as? CollectionViewWaterfallFlowLayout)!.columnWidth)
        self.navigationDelegate.discoverColumnWidth = (self.collectionViewLayout as? CollectionViewWaterfallFlowLayout)!.columnWidth
        self.updateLayoutForOrientation(UIApplication.sharedApplication().statusBarOrientation);
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.updateLayoutForOrientation(toInterfaceOrientation);
        self.collectionView.reloadData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // pragma mark - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var discoverCell = collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverCell", forIndexPath: indexPath) as DiscoverViewCell
        let columnWidth =  CGFloat((self.collectionViewLayout as CollectionViewWaterfallFlowLayout).columnWidth)
        discoverCell.restaurantName.text = "RESTAURANT NAME RESTAURANT NAME RESTAURANT NAME"
        discoverCell.restaurantName.preferredMaxLayoutWidth = columnWidth - 40
        
        discoverCell.cuisineName.text = "cuisine name cuisine name cuisine name cuisine name"
        discoverCell.cuisineName.preferredMaxLayoutWidth = columnWidth - 10
        
        discoverCell.logoView.image = UIImage(named: "logo.png")
        dispatch_async(dispatch_get_main_queue(), {
            if let discoverCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? DiscoverViewCell {
                discoverCell.imageView.image = self.images[indexPath.row]
            }
        })
        discoverCell.setNeedsLayout()
        return discoverCell
    }
    
//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//        var discoverSectionHeader : UICollectionReusableView! = nil
//        if (kind == CollectionViewWaterfallFlowLayoutElementKindSectionHeader) {
//            discoverSectionHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "DiscoverHeader", forIndexPath: indexPath) as UICollectionReusableView
//            discoverSectionHeader.layer.borderWidth = 1.0
//            discoverSectionHeader.layer.borderColor =  UIColor.blackColor().CGColor
//        }
//        return discoverSectionHeader
//    }
    
    // pragma mark - DiscoverNavigationTransitionProtocol
    func transitionCollectionView() -> UICollectionView! {
        return self.collectionView
    }
    
    func viewWillAppearWithIndex(index : NSInteger) {
        var position : UICollectionViewScrollPosition = .CenteredHorizontally & .CenteredVertically
        let image: UIImage! = self.images[index]
        let imageHeight = image.size.height *  self.columnWidth! / image.size.width
        if imageHeight > 400 {//whatever you like, it's the max value for height of image
            position = .Top
        }
        let currentIndexPath = NSIndexPath(forRow: index, inSection: 0)
        collectionView.setCurrentIndexPath(currentIndexPath)
        if index < 2 {
            collectionView.setContentOffset(CGPointZero, animated: false)
        }else{
            collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: position, animated: false)
        }
    }
    
    // pragma mark - CollectionViewDelegateWaterfallFlowLayout
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let image = self.images[indexPath.row]
        let columnWidth =  CGFloat((self.collectionViewLayout as CollectionViewWaterfallFlowLayout).columnWidth)
        let imageHeight = image.size.height * columnWidth / image.size.width
        
        // Find the size that the string occupies when displayed with the given font.
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .ByWordWrapping
        let restaurantText: NSString = "RESTAURANT NAME RESTAURANT NAME RESTAURANT NAME"
        let restaurantBoundingSize = restaurantText.boundingRectWithSize(CGSizeMake(columnWidth - 40, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size:12)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
        let cuisinetext = "cuisine name cuisine name cuisine name cuisine name" as NSString
        let cuisineBoundingSize = cuisinetext.boundingRectWithSize(CGSizeMake(columnWidth - 10, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Light", size:12)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
        let itemSize = CGSizeMake(columnWidth, ceil(restaurantBoundingSize.height) + imageHeight + ceil(cuisineBoundingSize.height) + 20)
        return itemSize
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let discoverDetailViewController = DiscoverDetailViewController(collectionViewLayout: generateDiscoverDetailViewLayout(), currentIndexPath:indexPath)
        discoverDetailViewController.images = self.images
        self.collectionView.setCurrentIndexPath(indexPath)
        self.navigationController!.pushViewController(discoverDetailViewController, animated: true)
    }
    
    func generateDiscoverDetailViewLayout() -> CollectionViewHorizontalFlowLayout {
        let discoverDetailLayout = CollectionViewHorizontalFlowLayout()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height

        discoverDetailLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - statusBarHeight - navigationBarHeight!)
        discoverDetailLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        discoverDetailLayout.minimumLineSpacing = 0
        discoverDetailLayout.minimumInteritemSpacing = 0
        discoverDetailLayout.scrollDirection = .Horizontal
        return discoverDetailLayout
    }
    
    func handleLongPress(longPress: UILongPressGestureRecognizer) {
        if (longPress.state != .Ended) {
            return
        }
        let point = longPress.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
            let discoverCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? DiscoverViewCell
            self.images[indexPath.row] = self.images[0]
            discoverCell!.imageView.image = self.images[0]
            self.collectionView.reloadItemsAtIndexPaths([indexPath])
            
        } else {
            println("couldn't find index path");
        }
    }

    private func updateLayoutForOrientation(orientation: UIInterfaceOrientation){
        let discoverLayout = self.collectionView.collectionViewLayout as? CollectionViewWaterfallFlowLayout
        discoverLayout!.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView]
        let collectionView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let collectionview_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-5-[collectionView]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(collectionview_constraint_V)
    }
}