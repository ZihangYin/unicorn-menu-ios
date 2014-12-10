//
//  RestaurantDetailCollectionViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/25/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class CuisineDetailViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    lazy var imageNames: [String] = {
        var _imageNames = [String]()
        for _ in 0 ... 20 {
            for index in 0 ... 6 {
                let imageName = String(format: "cuisine%02ld.jpg", index)
                _imageNames.append(imageName)
            }
        }
        return _imageNames
        }()
    
    let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    
    override init(collectionViewLayout layout: UICollectionViewLayout!) {
        super.init(collectionViewLayout:layout)
        
        self.collectionView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView!.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        self.collectionView!.pagingEnabled = true
        self.collectionView!.registerClass(CuisineDetailViewCell.self, forCellWithReuseIdentifier: "CuisineDetailViewCell")
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.showsHorizontalScrollIndicator = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.frame = CGRectMake(0.0, 0.0, 55, 55)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        negativeSpacer.width = -25
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftBarButton]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var edgePanRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges = .Left;
        self.collectionView!.addGestureRecognizer(edgePanRecognizer)
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = percentDrivenInteractiveTransition
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cuisineDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier("CuisineDetailViewCell", forIndexPath: indexPath) as CuisineDetailViewCell
        cuisineDetailCell.backgroundImageView.image = nil
        cuisineDetailCell.blurredBackgroundImageView.image = nil
        
        var cuisineName: NSString!
        if (Int(indexPath.item) % 3 == 0) {
            cuisineName = "Cuisine Name \(indexPath.item)";
        } else if (Int(indexPath.item) % 3 == 1) {
            cuisineName = "Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine Name \(indexPath.item)"
        } else {
            cuisineName = "Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine Name Cuisine \(indexPath.item)"
        }
        cuisineDetailCell.setCuisineName(cuisineName)
        dispatch_async(dispatch_get_main_queue(), {
            if let cuisineDetailCell = self.collectionView!.cellForItemAtIndexPath(indexPath) as? CuisineDetailViewCell {
                cuisineDetailCell.backgroundImageView.image = UIImage(named: self.imageNames[indexPath.item])!
                cuisineDetailCell.blurredBackgroundImageView.image = cuisineDetailCell.backgroundImageView.image!.applyBlurWithRadius(BLUR_RADIUS, tintColor: BLUR_TINT_COLOR, saturationDeltaFactor: BLUR_DELTA_FACTOR, maskImage: nil)
            }
        })
        cuisineDetailCell.cuisineLikesLabel.text = String(1000 - Int(indexPath.item))
        cuisineDetailCell.cuisinePriceLabel.text = "$ 25.00"
        cuisineDetailCell.scrollVerticallyToOffset(0.0)
        
        var cuisineDescription: NSString!
        if (Int(indexPath.item) % 3 == 0) {
            cuisineDescription = "Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans \(indexPath.item)";
        } else if (Int(indexPath.item) % 3 == 1) {
            cuisineDescription = "Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream, mixed berries and candied pecans Whipped mascarpone cream, mixed berries and candied pecans, Whipped mascarpone cream \(indexPath.item)"
        } else {
            cuisineDescription = "Description"
        }
        cuisineDetailCell.cuisineDescriptionLabel.text = cuisineDescription
        cuisineDetailCell.setNeedsLayout()
        return cuisineDetailCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        var index = 0
        for visibleCell in self.collectionView!.visibleCells() as [CuisineDetailViewCell] {
            let ratio = (self.collectionView!.contentOffset.x - visibleCell.frame.origin.x) / scrollView.frame.size.width;
            visibleCell.scrollHorizontalRatio(ratio)
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
