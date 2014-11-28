//
//  MenuViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/22/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var images = [UIImage]()
    var name = ["APPETIZER", "BARBEQUE", "BEER", "BEVERAGE", "DIM SUM", "DESSERT", "ENTREE",
        "HOT POT", "RAMEN", "PIZZA", "SANDWICHES",
        "SALAD", "SPECIAL", "SUSHI"]
    
    var restaurantImages = [UIImage(named: "restaurant0.jpg")!, UIImage(named: "restaurant1.jpg")!]
    var slide = 0
    var restaurantImageView: UIImageView!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Fill image array with images
        for index in 0 ... 13 {
            let imgName = String(format: "image%03ld.jpg", index)
            self.images.append(UIImage(named: imgName)!)
        }
        self.title = "RESTAURANT"
        
        self.restaurantImageView = UIImageView()
        self.restaurantImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantImageView.contentMode = .ScaleAspectFill
        self.view.addSubview(self.restaurantImageView)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(MenuViewCell.self, forCellWithReuseIdentifier: "MenuCell")
        self.collectionView.backgroundColor = UIColor.darkGrayColor()
        self.collectionView.showsVerticalScrollIndicator = false;
        self.collectionView.directionalLockEnabled = true
        self.view.addSubview(self.collectionView)
        
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
        
        self.changeSlide()
        
        // Loop gallery - fix loop: http://bynomial.com/blog/?p=67
        let timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("changeSlide"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
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
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
//        let restaurantDetailViewController = CuisineDetailViewController(image: UIImage(named: "dish00.jpg")!, cuisineName: "\(self.name[indexPath.item]) \(indexPath.item)", cuisineDescription: "DESCRIPTION")
//        restaurantDetailViewController.title = self.name[indexPath.item]
//        self.navigationController!.pushViewController(restaurantDetailViewController, animated: false)
        let cuisineDetailLayout = UICollectionViewFlowLayout()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        cuisineDetailLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - statusBarHeight - navigationBarHeight!)
        cuisineDetailLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cuisineDetailLayout.minimumLineSpacing = 0
        cuisineDetailLayout.minimumInteritemSpacing = 0
        cuisineDetailLayout.scrollDirection = .Horizontal
        
        let cuisineDetailViewController = CuisineDetailViewController(collectionViewLayout: cuisineDetailLayout)
        cuisineDetailViewController.title = self.name[indexPath.item]
        self.navigationController!.pushViewController(cuisineDetailViewController, animated: true)
    }
    
    // pragma mark - UIScrollViewdelegate methods
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for visibleCell in self.collectionView.visibleCells() as [MenuViewCell] {
            let yOffset = ((self.collectionView.contentOffset.y - visibleCell.frame.origin.y) / 200) * 25;
            visibleCell.imageOffset = CGPointMake(0.0, yOffset);
        }
    }
//    
//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < UIApplication.sharedApplication().statusBarFrame.size.height {
//            self.navigationController!.popViewControllerAnimated(true)
//        }
//    }
    
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
    
    func changeSlide() {
        if (slide > restaurantImages.count - 1) {
            slide = 0
        }
        let toImage = restaurantImages[slide]
        UIView.transitionWithView(self.restaurantImageView, duration: 0.75, options: .TransitionCrossDissolve | .CurveEaseInOut, animations: {
                self.restaurantImageView.image = toImage
            },
            completion: nil)
        slide++;
    }

    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView, "restaurantImageView": self.restaurantImageView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.view.addConstraint(NSLayoutConstraint(item: self.restaurantImageView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.4, constant: 0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantImageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[restaurantImageView]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}
