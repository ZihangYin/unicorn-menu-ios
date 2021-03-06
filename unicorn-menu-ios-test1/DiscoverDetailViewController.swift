//
//  DiscoverDetailViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@objc protocol DiscoverDetailViewControllerProtocol: DiscoverNavigationTransitionProtocol {
    func detailViewCellScrollViewContentOffset() -> CGPoint
}

class DiscoverDetailViewController: UICollectionViewController, UICollectionViewDataSource, DiscoverDetailViewControllerProtocol {
    
    var imageNames = [String]()
    var pullingOffset = CGPointZero
    
    init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: NSIndexPath) {
        super.init(collectionViewLayout:layout)
        
        self.collectionView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView!.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        self.collectionView!.pagingEnabled = true
        self.collectionView!.setToIndexPath(indexPath)
        self.collectionView!.registerClass(DiscoverDetailCollectionViewCell.self, forCellWithReuseIdentifier: "DiscoverDetailCollectionViewCell")
        self.collectionView!.performBatchUpdates({self.collectionView!.reloadData()}, completion: {finished in
            if finished {
                self.collectionView!.scrollToItemAtIndexPath(indexPath, atScrollPosition:.CenteredHorizontally, animated: false)
            }});
        self.collectionView!.dataSource = self
        self.collectionView!.showsHorizontalScrollIndicator = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.title = "RESTAURANT"
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.frame = CGRectMake(0.0, 0.0, 55, 55);
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        negativeSpacer.width = -25
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftBarButton]
        autoLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // pragma mark - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var discoverDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverDetailCollectionViewCell", forIndexPath: indexPath) as DiscoverDetailCollectionViewCell
        discoverDetailCell.cuisineImageName = self.imageNames[indexPath.item]
        discoverDetailCell.cuisineName = "CUISINE NAME \(indexPath.item)"
        discoverDetailCell.restaurantName = "RESTAURANT NAME \(indexPath.item)"
        discoverDetailCell.cuisineLikes =  String(1000 - indexPath.item)
        discoverDetailCell.pulledAction = {offset in
            self.pullingOffset = offset
            (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = nil
            self.navigationController!.popViewControllerAnimated(true)
        }
        discoverDetailCell.tappedAction = {() -> Void in
            let restaurantLayout: CollectionViewStickyHeaderLayout = CollectionViewStickyHeaderLayout()
            restaurantLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            restaurantLayout.minimumLineSpacing = 1
            restaurantLayout.minimumInteritemSpacing = 0
            self.navigationController!.pushViewController(RestaurantViewController(collectionViewLayout: restaurantLayout), animated: true)
        }
        
        discoverDetailCell.collectionView.reloadData()
        discoverDetailCell.setNeedsLayout()
        return discoverDetailCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageNames.count
    }
    
    // pragma mark - DiscoverDetailViewControllerProtocol
    func transitionCollectionView() -> UICollectionView! {
        return self.collectionView
    }
    
    func detailViewCellScrollViewContentOffset() -> CGPoint {
        return self.pullingOffset
    }
    
    func backButtonPressed() {
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = nil
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView!]
        let collectionView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let collectionview_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(collectionview_constraint_V)
    }
}
