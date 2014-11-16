//
//  ViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/7/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, CollectionViewDelegateWaterfallFlowLayout, UICollectionViewDataSource {
    
    lazy var cellSizes: [CGSize] = {
        var _cellSizes = [CGSize]()
        for _ in 0 ... 100 {
            let random = Int(arc4random_uniform((UInt32(100))))
            _cellSizes.append(CGSize(width: 140, height: 100 + random))
        }
        
        return _cellSizes
    }()
    
    var navController: UINavigationController?
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        self.navController = self.navigationController
        
        let layout: CollectionViewWaterfallFlowLayout = CollectionViewWaterfallFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.columnCount = 2
        layout.headerHeight = 30
        layout.minimumColumnSpacing = 7
        layout.minimumInteritemSpacing = 7
        
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.collectionView!.setTranslatesAutoresizingMaskIntoConstraints(false)

        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView!.registerClass(CollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallFlowLayoutElementKindSectionHeader, withReuseIdentifier: "Header")
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(collectionView!)
        self.view.sendSubviewToBack(collectionView!)
        
        var viewsDictionary = ["collectionView": self.collectionView!, "topLayoutGuide": self.topLayoutGuide]        
        let collectionView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-7-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(view_constraint_V)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.updateLayoutForOrientation(UIApplication.sharedApplication().statusBarOrientation);
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.updateLayoutForOrientation(toInterfaceOrientation);
    }
    
    func updateLayoutForOrientation(orientation: UIInterfaceOrientation){
        let layout = self.collectionView!.collectionViewLayout as? CollectionViewWaterfallFlowLayout
        layout!.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return cellSizes[indexPath.item]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as CollectionViewCell
        cell.textLabel.text = String(indexPath.row)
        cell.layer.cornerRadius = 7.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor =  UIColor.whiteColor().CGColor
        cell.backgroundColor =  UIColor.lightGrayColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView! = nil
        if (kind == CollectionViewWaterfallFlowLayoutElementKindSectionHeader) {
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as UICollectionReusableView
            reusableView.layer.borderWidth = 1.0
            reusableView.layer.borderColor =  UIColor.blackColor().CGColor

        }
        
        return reusableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}