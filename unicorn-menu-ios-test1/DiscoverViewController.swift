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
            _cellSizes.append(CGSize(width: 140, height: 50 + random))
        }
        
        return _cellSizes
    }()
    
//    var navView: NavView?
    var navController: PullDownNavigationController?
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
//        self.navView = NavView(frame: CGRectMake(0, 0, self.view.frame.width, 40))
//        self.navView!.layer.borderWidth = 1.0
//        self.navView!.layer.borderColor =  UIColor.blackColor().CGColor
//        self.view.addSubview(navView!)
        
//        self.automaticallyAdjustsScrollViewInsets = false;
        
        
//        self.navController!.activatePullDownNavigationBar()
//
//        var gridBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        gridBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 60)
//        gridBtn.tintColor = UIColor.blackColor()
//        gridBtn.setImage(UIImage(named: "scan@3x.png"), forState: UIControlState.Normal)
//        gridBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 20);
//        var leftButton = UIBarButtonItem.init(customView: gridBtn)
//        self.navigationItem.leftBarButtonItem = leftButton
//        
//        var mapBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        mapBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 60)
//        mapBtn.tintColor = UIColor.blackColor()
//        mapBtn.setImage(UIImage(named: "map2.png"), forState: UIControlState.Normal)
//        mapBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 10, 0);
//        var rightButton = UIBarButtonItem.init(customView: mapBtn)
//        self.navigationItem.rightBarButtonItem = rightButton
        
        self.title = "DISCOVER"
        self.edgesForExtendedLayout = .None
        self.navController = self.navigationController as? PullDownNavigationController
        
        let layout: CollectionViewWaterfallFlowLayout = CollectionViewWaterfallFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.columnCount = 2
        layout.headerHeight = 30
        layout.minimumColumnSpacing = 7
        layout.minimumInteritemSpacing = 7
        
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.collectionView!.setTranslatesAutoresizingMaskIntoConstraints(false)

//        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
//        self.collectionView!.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView!.registerClass(CollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallFlowLayoutElementKindSectionHeader, withReuseIdentifier: "Header")
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(collectionView!)
        self.view.sendSubviewToBack(collectionView!)
        
        self.navController!.navBar = NavView(frame: CGRectZero)
        self.navController!.navBar!.backgroundColor = UIColor.blackColor()
        self.navController!.navBar!.layer.borderWidth = 1.0
        self.navController!.navBar!.layer.borderColor = UIColor.grayColor().CGColor
        self.navController!.navBar!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.navController!.navBar!)
        self.navController!.activatePullDownNavigationBar()
        
//        self.navController!.navBar = NavView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 50 - self.view.frame.origin.y, self.view.frame.width, 50))
//        self.navController!.navBar!.backgroundColor = UIColor.blackColor()
//        println("\(self.navController!.navBar!.frame)")
//        self.navController!.view.addSubview(self.navController!.navBar!)    //498   518
        
        var viewsDictionary = ["collectionView": self.collectionView!, "topLayoutGuide": self.topLayoutGuide, "navBarView": self.navController!.navBar!]
        
        
        let navView_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[navBarView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let collectionView_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let view_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-7-[navBarView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(navView_constraint_H)
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(view_constraint_V)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.updateLayoutForOrientation(UIApplication.sharedApplication().statusBarOrientation);
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
    
    func pullDownNavigationBar() -> Void {
        self.navController!.pullDownNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}