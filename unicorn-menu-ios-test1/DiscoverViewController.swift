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
//        self.navView = NavView(frame: CGRectMake(0, 20, self.view.frame.width, 40))
//        self.navView!.layer.borderWidth = 1.0
//        self.navView!.layer.borderColor =  UIColor.blackColor().CGColor
//        self.view.addSubview(navView!)
        
        self.title = "Discover"
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.navController = self.navigationController as? PullDownNavigationController
        self.navController!.setNavigationBarHidden(false, animated: false)
        self.navController!.activatePullDownNavigationBar()
        
        var rightBarButton = UIBarButtonItem(image: UIImage(named: "scan@3x.png"), style: .Plain, target: self, action: "menuPressed")
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let layout: CollectionViewWaterfallFlowLayout = CollectionViewWaterfallFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.columnCount = 2
        layout.headerHeight = 30
        layout.minimumColumnSpacing = 7
        layout.minimumInteritemSpacing = 7
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, self.navController!.navigationBar.frame.origin.y + self.navController!.navigationBar.frame.height,
            self.view.frame.width, self.view.frame.height), collectionViewLayout: layout)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView!.registerClass(CollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallFlowLayoutElementKindSectionHeader, withReuseIdentifier: "Header")
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.collectionView!.layer.borderWidth = 1.0
        self.collectionView!.layer.borderColor =  UIColor.blackColor().CGColor
        self.view.addSubview(collectionView!)
        self.view.sendSubviewToBack(collectionView!)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return cellSizes[indexPath.item]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as CollectionViewCell
        cell.textLabel.text = String(indexPath.row)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor =  UIColor.blackColor().CGColor
        
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
    
    func menuPressed() -> Void {
        self.navController!.pullDownAndUpNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}