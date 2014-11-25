//
//  MenuViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/22/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class MenuViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var images = [UIImage]()
    var name = ["APPETIZER", "BARBEQUE", "BEER", "BEVERAGE", "DIM SUM", "DESSERT", "ENTREE",
        "HOT POT", "RAMEN", "PIZZA", "SANDWICHES",
        "SALAD", "SPECIAL", "SUSHI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Fill image array with images
        for index in 0 ... 13 {
            let imgName = String(format: "image%03ld.jpg", index)
            self.images.append(UIImage(named: imgName)!)
        }
        
        self.title = "RESTAURANT"
        
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(MenuViewCell.self, forCellWithReuseIdentifier: "MenuCell")
        self.collectionView.backgroundColor = UIColor.darkGrayColor()
        self.collectionView.showsVerticalScrollIndicator = false;
        self.collectionView.directionalLockEnabled = true
        
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.frame = CGRectMake(0.0, 0.0, 40, 40)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        negativeSpacer.width = -10
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftBarButton]
        
        autoLayoutSubviews()
        self.collectionView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        (self.navigationController!.navigationBar as DiscoverNavigationBarView).title.text = "RESTAURANT NAME"
//        (self.navigationController!.navigationBar as DiscoverNavigationBarView).filterButton.hidden = true
    }
    
    // pragma mark - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var menuCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("MenuCell", forIndexPath: indexPath) as MenuViewCell
        
        menuCell.text.text = self.name[indexPath.item]
        menuCell.imageView.image = self.images[indexPath.item]
        let yOffset = ((self.collectionView.contentOffset.y - menuCell.frame.origin.y) / 200) * 25
        menuCell.imageOffset = CGPointMake(0.0, yOffset);
        
        dispatch_async(dispatch_get_main_queue(), {
            if let menuCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? MenuViewCell {
                menuCell.imageView.image = self.images[indexPath.item]
            }
        })
        menuCell.setNeedsLayout()
        
        let longPressImage = UILongPressGestureRecognizer.init(target: self, action: "handleLongPressImage:")
        menuCell.imageView.addGestureRecognizer(longPressImage)
        return menuCell;
    }
    
    // pragma mark - UIScrollViewdelegate methods
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        for visibleCell in self.collectionView.visibleCells() as [MenuViewCell] {
            let yOffset = ((self.collectionView.contentOffset.y - visibleCell.frame.origin.y) / 200) * 25;
            visibleCell.imageOffset = CGPointMake(0.0, yOffset);
        }
    }
    
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < UIApplication.sharedApplication().statusBarFrame.size.height {
            self.navigationController!.popViewControllerAnimated(true)
        }
    }
    
    func backButtonPressed() {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func handleLongPressImage(longPress: UILongPressGestureRecognizer) {
        let point = longPress.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
            let menuCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? MenuViewCell
            
                switch (longPress.state) {
                case .Began, .Changed:
                    menuCell?.imageView.layer.backgroundColor = UIColor.blackColor().CGColor
                    menuCell?.imageView.layer.opacity = 0.7
                case .Ended, .Cancelled:
                    menuCell?.imageView.layer.backgroundColor = UIColor.clearColor().CGColor
                    menuCell?.imageView.layer.opacity = 1
                default:
                    break
            }
        }
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView]
        let collectionView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let collectionview_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(collectionView_constraint_H)
        self.view.addConstraints(collectionview_constraint_V)
    }
}
