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
    
    var images = [UIImage]()
    var pullingOffset = CGPointZero
    var page: CGFloat = 0.0
    
    init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: NSIndexPath){
        super.init(collectionViewLayout:layout)
        
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.pagingEnabled = true
        self.collectionView.setCurrentIndexPath(indexPath)
        self.collectionView.registerClass(DiscoverDetailCollectionViewCell.self, forCellWithReuseIdentifier: "DiscoverDetailCollectionViewCell")
        self.collectionView.performBatchUpdates({self.collectionView.reloadData()}, completion: {finished in
            if finished {
                self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:.CenteredHorizontally, animated: false)
            }});
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.collectionView.dataSource = self
        autoLayoutSubviews()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.updateLayoutForOrientation(UIApplication.sharedApplication().statusBarOrientation);
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.page = self.collectionView.contentOffset.x / UIScreen.mainScreen().bounds.size.width;
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.updateLayoutForOrientation(toInterfaceOrientation);
    }
    
    // pragma mark - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var discoverDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverDetailCollectionViewCell", forIndexPath: indexPath) as DiscoverDetailCollectionViewCell
        discoverDetailCell.image = self.images[indexPath.row]
        discoverDetailCell.pulledAction = {offset in
            self.pullingOffset = offset
            self.navigationController!.popViewControllerAnimated(true)
        }
        discoverDetailCell.setNeedsLayout()
        return discoverDetailCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count;
    }
    
    // pragma mark - DiscoverDetailViewControllerProtocol
    func transitionCollectionView() -> UICollectionView! {
        return self.collectionView
    }
    
    func detailViewCellScrollViewContentOffset() -> CGPoint {
        return self.pullingOffset
    }
    
    private func updateLayoutForOrientation(orientation: UIInterfaceOrientation){
 
        let discoverDetailLayout = self.collectionView.collectionViewLayout as? CollectionViewHorizontalFlowLayout
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        discoverDetailLayout!.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - statusBarHeight - navigationBarHeight!)
        discoverDetailLayout!.page = self.page
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView]
        let collectionView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let collectionview_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(collectionview_constraint_V)
    }
}
