//
//  ViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/7/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DiscoverViewControllerProtocol : DiscoverNavigationTransitionProtocol {
    func viewWillAppearWithIndex(index : NSInteger)
}

class DiscoverViewController: UICollectionViewController, CollectionViewDelegateWaterfallFlowLayout, UICollectionViewDataSource, DiscoverViewControllerProtocol {
    
    lazy var images: [UIImage] = {
        var _images = [UIImage]()
        for index in 1 ... 30 {
            let imageName = String(format: "dish%02ld.jpg", index)
            _images.append(UIImage(named: imageName)!)
        }
        return _images
    }()
    
    let navigationDelegate = DiscoverNavigationControllerDelegate()
    let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    var columnWidth: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.navigationController! as DiscoverNavigationController).activatePullDownNavigationBar()
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "list.png"), forState: UIControlState.Normal)
        leftButton.frame = CGRectMake(0.0, 0.0, 40, 40);
        leftButton.addTarget(self, action: "leftButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let leftNegativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        leftNegativeSpacer.width = -10
        self.navigationItem.leftBarButtonItems = [leftNegativeSpacer, leftBarButton]
        (self.navigationController!.navigationBar as DiscoverNavigationBarView).scanButton.addTarget(self, action: "scanPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.title = "DISCOVER"
        self.edgesForExtendedLayout = .None
        
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(DiscoverViewCell.self, forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionView.backgroundColor = UIColor.darkGrayColor()
        self.collectionView.directionalLockEnabled = true
        
        autoLayoutSubviews()
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        var edgePanRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges = .Left;
        self.view.addGestureRecognizer(edgePanRecognizer)
        self.navigationDelegate.interactiveTransition = percentDrivenInteractiveTransition
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.columnWidth = CGFloat((self.collectionViewLayout as? CollectionViewWaterfallFlowLayout)!.columnWidth)
        self.navigationController!.delegate = navigationDelegate
        self.navigationDelegate.discoverColumnWidth = (self.collectionViewLayout as? CollectionViewWaterfallFlowLayout)!.columnWidth
        self.updateLayoutForOrientation(UIApplication.sharedApplication().statusBarOrientation);
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.updateLayoutForOrientation(toInterfaceOrientation);
        self.collectionView.reloadData()
    }
    
    // pragma mark - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var discoverCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverCell", forIndexPath: indexPath) as DiscoverViewCell
        let columnWidth =  CGFloat((self.collectionViewLayout as CollectionViewWaterfallFlowLayout).columnWidth)
        
        discoverCell.restaurantName.text = "RESTAURANT NAME \(indexPath.item)"
        discoverCell.restaurantName.preferredMaxLayoutWidth = columnWidth - 40

        discoverCell.cuisineName.text = "CUISINE NAME \(indexPath.item)"
        discoverCell.cuisineName.preferredMaxLayoutWidth = columnWidth - 40

        discoverCell.logoView.image = UIImage(named: "logo.png")
        discoverCell.cuisineImage.image = self.images[indexPath.item]
        discoverCell.cuisineLikesLabel.text = String(1000 - indexPath.item)

//        dispatch_async(dispatch_get_main_queue(), {
//            if let discoverCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? DiscoverViewCell {
//                discoverCell.cuisineImage.image = self.images[indexPath.item]
//           }
//        })
        
        discoverCell.setNeedsLayout()
        let tapImage = UITapGestureRecognizer.init(target: self, action: "handleTapImage:")
        discoverCell.cuisineImage.addGestureRecognizer(tapImage)

        let tapRestaurantLogo = UITapGestureRecognizer.init(target: self, action: "handleTapRestaurant:")
        discoverCell.restaurantView.addGestureRecognizer(tapRestaurantLogo)
//        let tapRestaurantName = UITapGestureRecognizer.init(target: self, action: "handleTapRestaurant:")
//        discoverCell.restaurantName.addGestureRecognizer(tapRestaurantName)

        return discoverCell
    }
    
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
        collectionView.setToIndexPath(currentIndexPath)
        if index < 2 {
            collectionView.setContentOffset(CGPointZero, animated: false)
        } else {
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
        let restaurantText: NSString = "RESTAURANT NAME \(indexPath.item)"
        let restaurantBoundingSize = restaurantText.boundingRectWithSize(CGSizeMake(columnWidth - 40, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size:12)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
        let cuisinetext = "CUISINE NAME \(indexPath.item)" as NSString
        let cuisineBoundingSize = cuisinetext.boundingRectWithSize(CGSizeMake(columnWidth - 20, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Light", size:12)!, NSParagraphStyleAttributeName: paraStyle], context: nil)

        let itemSize = CGSizeMake(columnWidth, ceil(restaurantBoundingSize.height) + imageHeight + ceil(cuisineBoundingSize.height) + 60)
        return itemSize
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
    
    func handleTapImage(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }
        let point = tap.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
            let discoverDetailViewController = DiscoverDetailViewController(collectionViewLayout: generateDiscoverDetailViewLayout(), currentIndexPath:indexPath)
            discoverDetailViewController.images = self.images
            self.collectionView.setToIndexPath(indexPath)
            self.navigationController!.pushViewController(discoverDetailViewController, animated: true)
        }
    }
    
    func handleTapRestaurant(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }
        let point = tap.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
            let menuViewController = MenuViewController()
            self.navigationController!.pushViewController(menuViewController, animated: true)
        }
    }
    
    func handleLongPress(longPress: UILongPressGestureRecognizer) {
        if (longPress.state != .Ended) {
            return
        }
        let point = longPress.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
            let discoverCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? DiscoverViewCell
            self.images[indexPath.row] = self.images[0]
            discoverCell!.cuisineImage.image = self.images[0]
            self.collectionView.reloadItemsAtIndexPaths([indexPath])
            
        }
    }
    
    func handleEdgePanRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
        var progress: CGFloat = recognizer.translationInView(self.view).x / self.view.bounds.size.width / CGFloat(2.5)
        progress = min(1.0, max(0.0, progress))
        switch (recognizer.state) {
        case .Began:
            self.navigationController!.pushViewController(FilterViewController(), animated: true)
        case .Changed:
            self.percentDrivenInteractiveTransition.updateInteractiveTransition(progress);
        default:
            if recognizer.velocityInView(self.view).x >= 0 {
                self.percentDrivenInteractiveTransition.finishInteractiveTransition()
                self.view.removeGestureRecognizer(recognizer)
            } else {
                self.percentDrivenInteractiveTransition.cancelInteractiveTransition()
            }
            break;
        }
    }
    
    func leftButtonPressed() -> Void {
        self.navigationDelegate.interactiveTransition  = nil
        self.navigationController!.pushViewController(FilterViewController(), animated: true)
    }
    
    func scanPressed() -> Void {
        (self.navigationController! as DiscoverNavigationController).pullDownAndUpNavigationBar()
    }

    private func updateLayoutForOrientation(orientation: UIInterfaceOrientation){
        let discoverLayout = self.collectionView.collectionViewLayout as? CollectionViewWaterfallFlowLayout
        discoverLayout!.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView]
        let collectionView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let collectionview_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(collectionview_constraint_V)
    }
}