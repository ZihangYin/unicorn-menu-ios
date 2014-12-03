//
//  RestaurantViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/3/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class RestaurantViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var images = [UIImage]()
    var name = ["APPETIZER", "BARBEQUE", "BEER", "BEVERAGE", "DIM SUM", "DESSERT", "ENTREE",
        "HOT POT", "RAMEN", "PIZZA", "SANDWICHES",
        "SALAD", "SPECIAL", "SUSHI"]
    
    let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0 ... 13 {
            let imgName = String(format: "image%03ld.jpg", index)
            self.images.append(UIImage(named: imgName)!)
        }
        self.title = "RESTAURANT"
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.frame = CGRectMake(0.0, 0.0, 55, 55)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        negativeSpacer.width = -25
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftBarButton]
        
        var layout = self.collectionViewLayout as CollectionViewStickyHeaderLayout
        
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 350)
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 70)
        layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 120)
        layout.parallaxHeaderAlwaysOnTop = true
        
        // Also insets the scroll indicator so it appears below the search bar
        self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.collectionView.registerClass(MenuViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.registerClass(RestaurantCardView.self, forSupplementaryViewOfKind: CollectionViewStickyHeaderLayoutElementKindSectionHeader, withReuseIdentifier: "Header")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var edgePanRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges = .Left;
        self.collectionView.addGestureRecognizer(edgePanRecognizer)
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = percentDrivenInteractiveTransition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.images.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let menuCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as MenuViewCell
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
        return menuCell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var header: UICollectionReusableView! = nil
        if (kind == CollectionViewStickyHeaderLayoutElementKindSectionHeader) {
            var header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as RestaurantCardView
            return header
        }
        return header
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
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
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        for visibleCell in self.collectionView.visibleCells() as [MenuViewCell] {
            let yOffset = ((self.collectionView.contentOffset.y - visibleCell.frame.origin.y) / 200) * 25;
            visibleCell.imageOffset = CGPointMake(0.0, yOffset);
        }
    }
    
    func backButtonPressed() {
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = nil
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func handleEdgePanRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        var progress: CGFloat = recognizer.translationInView(self.view).x / self.view.bounds.size.width / CGFloat(2.5)
        progress = min(1.0, max(0.0, progress))
        switch (recognizer.state) {
        case .Began:
            self.navigationController!.popViewControllerAnimated(true)
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
}
