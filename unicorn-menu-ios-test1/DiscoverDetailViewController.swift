//
//  DiscoverDetailViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class DiscoverDetailViewController: UICollectionViewController {
    
    var images = [UIImage]()
    var pullingOffset = CGPointZero
    
    init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: NSIndexPath){
        super.init(collectionViewLayout:layout)
        
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.pagingEnabled = true
        self.collectionView.registerClass(DiscoverDetailCollectionViewCell.self, forCellWithReuseIdentifier: "DiscoverDetailCollectionViewCell")
        self.collectionView.performBatchUpdates({self.collectionView.reloadData()}, completion: {finished in
            if finished {
                self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:.CenteredHorizontally, animated: false)
            }});
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var discoverDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverDetailCollectionViewCell", forIndexPath: indexPath) as DiscoverDetailCollectionViewCell
        discoverDetailCell.image = self.images[indexPath.row]
        discoverDetailCell.tappedAction = {}
        discoverDetailCell.pulledAction = {offset in
            self.pullingOffset = offset
            self.navigationController!.popViewControllerAnimated(true)
        }
        discoverDetailCell.setNeedsLayout()
        return discoverDetailCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.images.count;
    }
//    
//    func transitionCollectionView() -> UICollectionView!{
//        return collectionView
//    }
//    
//    func detailViewCellScrollViewContentOffset() -> CGPoint{
//        return self.pullOffset
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView]
        let collectionView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let collectionview_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(collectionview_constraint_V)
    }
}
