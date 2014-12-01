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
    var restaurantView: UIView!
    var restaurantLogo: UIImageView!
    var hourLabel: UILabel!
    var phoneLabel: UILabel!
    var restaurantAddressView: UIView!
    var addressLabel: UILabel!
    var collectionView: UICollectionView!
//    var backgroundScrollView: UIScrollView!
    var constraintView: UIView!
    
    let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Fill image array with images
        for index in 0 ... 13 {
            let imgName = String(format: "image%03ld.jpg", index)
            self.images.append(UIImage(named: imgName)!)
        }
        self.title = "RESTAURANT"
        
        self.constraintView = UIView()
        self.constraintView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.constraintView)
        
        self.restaurantImageView = UIImageView()
        self.restaurantImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantImageView.contentMode = .ScaleAspectFill
        self.restaurantImageView.clipsToBounds = true
        self.constraintView.addSubview(self.restaurantImageView)
        
        self.restaurantView = UIView()
        self.restaurantView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantView.backgroundColor = UIColor(white: 0.0, alpha: 0.25)
        self.constraintView.addSubview(self.restaurantView)

        self.restaurantAddressView = UIView()
        self.restaurantAddressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantAddressView.backgroundColor = UIColor(white: 0.0, alpha: 0.25)
        self.constraintView.addSubview(self.restaurantAddressView)
        
        self.restaurantLogo = UIImageView(image: UIImage(named: "logo.png"))
        self.restaurantLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantLogo.clipsToBounds = true
        self.restaurantView.addSubview(self.restaurantLogo)
        
        self.hourLabel = UILabel()
        self.hourLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.hourLabel.text = "Hours: 9am - 9pm"
        self.hourLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.hourLabel.textAlignment = .Center
        self.hourLabel.textColor = UIColor.whiteColor()
        self.restaurantView.addSubview(self.hourLabel)
        
        self.phoneLabel = UILabel()
        self.phoneLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.phoneLabel.text = "Tel: 9196274749"
        self.phoneLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.phoneLabel.textAlignment = .Center
        self.phoneLabel.textColor = UIColor.whiteColor()
        self.restaurantView.addSubview(self.phoneLabel)
        
        self.addressLabel = UILabel()
        self.addressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addressLabel.text = "4535 12th Ave. NE, Seattle, WA 98101"
        self.addressLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.addressLabel.textAlignment = .Center
        self.addressLabel.textColor = UIColor.whiteColor()
        self.restaurantAddressView.addSubview(self.addressLabel)
        
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
        self.constraintView.addSubview(self.collectionView)
        
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
        
        var panRecognizer = UIPanGestureRecognizer.init(target: self, action: "handlePanRecognizer:")
        self.view.addGestureRecognizer(panRecognizer)
        var edgePanRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges = .Left;
        self.collectionView.addGestureRecognizer(edgePanRecognizer)
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = percentDrivenInteractiveTransition
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if (scrollView.tag == 1) {
            if scrollView.contentOffset.y < -80 {
                self.navigationController!.popViewControllerAnimated(true)
            }
        }
    }
    
    func backButtonPressed() {
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = nil
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
    
    func handlePanRecognizer(recognizer: UIPanGestureRecognizer) {
        var progress: CGFloat = recognizer.translationInView(self.view).y / self.view.bounds.size.height
        switch (recognizer.state) {
        case .Began:
            self.navigationController!.popViewControllerAnimated(true)
        case .Changed:
            self.percentDrivenInteractiveTransition.updateInteractiveTransition(progress);
        case .Ended, .Cancelled:
            if (progress > 0.3) {
                self.percentDrivenInteractiveTransition.finishInteractiveTransition()
                self.view.removeGestureRecognizer(recognizer)
            } else {
                self.percentDrivenInteractiveTransition.cancelInteractiveTransition()
            }
        default:
            break;
        }
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
   
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[constraintView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["constraintView": self.constraintView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[constraintView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["topLayoutGuide": self.topLayoutGuide, "constraintView": self.constraintView]))
        
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView, "restaurantImageView": self.restaurantImageView, "restaurantView": self.restaurantView, "restaurantAddressView": restaurantAddressView]
        self.constraintView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.constraintView.addConstraint(NSLayoutConstraint(item: self.restaurantImageView, attribute: .Height, relatedBy: .Equal, toItem: self.constraintView, attribute: .Height, multiplier: 0.36, constant: 0))
        self.constraintView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantImageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.constraintView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[restaurantImageView]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.constraintView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.constraintView.addConstraint(NSLayoutConstraint(item: self.restaurantView, attribute: .Height, relatedBy: .Equal, toItem: self.restaurantImageView, attribute: .Height, multiplier: 0.8, constant: 0))
        self.constraintView.addConstraint(NSLayoutConstraint(item: self.restaurantView, attribute: .Top, relatedBy: .Equal, toItem: self.restaurantImageView, attribute: .Top, multiplier: 1, constant: 0))
        self.constraintView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantAddressView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.constraintView.addConstraint(NSLayoutConstraint(item: self.restaurantAddressView, attribute: .Height, relatedBy: .Equal, toItem: self.restaurantImageView, attribute: .Height, multiplier: 0.2, constant: 0))
        self.constraintView.addConstraint(NSLayoutConstraint(item: self.restaurantAddressView, attribute: .Bottom, relatedBy: .Equal, toItem: self.restaurantImageView, attribute: .Bottom, multiplier: 1, constant: 0))
       
        self.restaurantLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[restaurantLogoView(80)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["restaurantLogoView": self.restaurantLogo]))
        self.restaurantLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[restaurantLogoView(80)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["restaurantLogoView": self.restaurantLogo]))
        
        viewsDictionary = ["hourLabel": self.hourLabel, "phoneLabel": self.phoneLabel, "addressLabel": self.addressLabel, "restaurantLogoView": self.restaurantLogo, "restaurantView": self.restaurantView, "restaurantAddressView": restaurantAddressView]
        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[restaurantLogoView]-20-[hourLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[restaurantLogoView]-20-[phoneLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.hourLabel, attribute: .Height, relatedBy: .Equal, toItem: self.restaurantLogo, attribute: .Height, multiplier: 0.5, constant: 0))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.phoneLabel, attribute: .Height, relatedBy: .Equal, toItem: self.restaurantLogo, attribute: .Height, multiplier: 0.5, constant: 0))
        
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.hourLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterY, multiplier: 1, constant: 10))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.phoneLabel, attribute: .Top, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterY, multiplier: 1, constant: 10))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.restaurantLogo, attribute: .CenterY, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterY, multiplier: 1, constant: 10))
        self.restaurantAddressView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[addressLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantAddressView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[addressLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}
