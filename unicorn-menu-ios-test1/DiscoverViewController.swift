//
//  ViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/7/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

@objc protocol DiscoverViewControllerProtocol : DiscoverNavigationTransitionProtocol {
    func viewWillAppearWithIndex(index : NSInteger)
}

class DiscoverViewController: UIViewController, CollectionViewDelegateWaterfallFlowLayout, UICollectionViewDataSource, DiscoverViewControllerProtocol, MKMapViewDelegate {
    
    lazy var images: [UIImage] = {
        var _images = [UIImage]()
        
        for _ in 1 ... 10 {
            for index in 1 ... 30 {
                let imageName = String(format: "dish%02ld.jpg", index)
                _images.append(UIImage(named: imageName)!)
            }
        }
        return _images
    }()
    
    let navigationDelegate = DiscoverNavigationControllerDelegate()
//    let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    var columnWidth: CGFloat?
    
    var isMapShowing = false
    var collectionView: UICollectionView!
    var mapView: MapView!
    var userLocation = UserLocation()
    var center: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userLocation.requestLocation()
//        (self.navigationController! as DiscoverNavigationController).activatePullDownNavigationBar()
        
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "filter.png"), forState: UIControlState.Normal)
        leftButton.frame = CGRectMake(0.0, 0.0, 64, 64);
        leftButton.addTarget(self, action: "leftButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let leftNegativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        leftNegativeSpacer.width = -25
        self.navigationItem.leftBarButtonItems = [leftNegativeSpacer, leftBarButton]
        
        var rightButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        rightButton.setImage(UIImage(named: "map.png"), forState: UIControlState.Normal)
        rightButton.frame = CGRectMake(0.0, 0.0, 50, 50);
        rightButton.addTarget(self, action: "mapPressed", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButton = UIBarButtonItem.init(customView: rightButton)
        let rightNegativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        rightNegativeSpacer.width = -15
        self.navigationItem.rightBarButtonItems = [rightNegativeSpacer, rightBarButton]

        let titleView = UIImageView(image: UIImage(named: "yumbook.png"))
        self.navigationItem.titleView = titleView
        
        self.edgesForExtendedLayout = .None
        
        let discoverLayout: CollectionViewWaterfallFlowLayout = CollectionViewWaterfallFlowLayout()
        discoverLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        discoverLayout.columnCount = 2
        discoverLayout.minimumColumnSpacing = 7
        discoverLayout.minimumInteritemSpacing = 7
        
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: discoverLayout)
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(DiscoverViewCell.self, forCellWithReuseIdentifier: "DiscoverCell")
        self.collectionView.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        self.collectionView.directionalLockEnabled = true
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.mapView = MapView(frame: CGRectZero)
        self.mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mapView.mapView.delegate = self
        
        self.view.addSubview(self.collectionView)
        autoLayoutSubviews()
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
//        var edgePanRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: "handleEdgePanRecognizer:")
//        edgePanRecognizer.edges = .Left;
//        self.view.addGestureRecognizer(edgePanRecognizer)
//        self.navigationDelegate.interactiveTransition = percentDrivenInteractiveTransition
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController!.delegate = navigationDelegate
        self.navigationDelegate.discoverColumnWidth = (self.collectionView.collectionViewLayout as? CollectionViewWaterfallFlowLayout)!.columnWidth
    }
    
    // pragma mark - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var discoverCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverCell", forIndexPath: indexPath) as DiscoverViewCell
        if (Int(indexPath.item) % 3 == 0) {
            discoverCell.restaurantName.text = "RESTAURANTRESTAURANT"
        } else if (Int(indexPath.item) % 3  == 1) {
            discoverCell.restaurantName.text = "RESTAURANT NAME RESTAURANT NAME \(indexPath.item)"
        } else {
            discoverCell.restaurantName.text = "RESTAURANT"
        }
        discoverCell.restaurantName.preferredMaxLayoutWidth = self.columnWidth! - 65

        if (Int(indexPath.item)%3 == 0) {
            discoverCell.cuisineName.text = "CUISINE NAME\(indexPath.item)";
        } else if (Int(indexPath.item)%3 == 1) {
            discoverCell.cuisineName.text = "CUISINE NAME CUISINE NAME \(indexPath.item)"
        } else {
            discoverCell.cuisineName.text = "CUISINE NAME CUISINE NAME CUISINE NAME CUISINE NAME \(indexPath.item)"
        }
        discoverCell.cuisineName.preferredMaxLayoutWidth = self.columnWidth! - 20

        discoverCell.logoView.image = UIImage(named: "logo.png")
        discoverCell.setCuisineImage(self.images[indexPath.item])
        discoverCell.cuisineLikesLabel.text = String(1000 - indexPath.item)

//        dispatch_async(dispatch_get_main_queue(), {
//            if let discoverCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? DiscoverViewCell {
//                discoverCell.cuisineImage.image = self.images[indexPath.item]
//           }
//        })
        
        discoverCell.setNeedsLayout()
        let tapImage = UITapGestureRecognizer(target: self, action: "handleTapImage:")
        discoverCell.cuisineImage.addGestureRecognizer(tapImage)

        let tapRestaurantLogo = UITapGestureRecognizer(target: self, action: "handleTapRestaurant:")
        discoverCell.restaurantView.addGestureRecognizer(tapRestaurantLogo)

        return discoverCell
    }
    
    // pragma mark - DiscoverNavigationTransitionProtocol
    func transitionCollectionView() -> UICollectionView! {
        return self.collectionView
    }
    
    func viewWillAppearWithIndex(index : NSInteger) {
        var position : UICollectionViewScrollPosition = .CenteredHorizontally & .CenteredVertically
        let image: UIImage! = self.images[index]
        let imageHeight = image.size.height *  self.columnWidth! / image.size.width
        if imageHeight > 400 {//whatever you like, it's the max value for height of image
            position = .Top
        }
        let currentIndexPath = NSIndexPath(forRow: index, inSection: 0)
        collectionView.setToIndexPath(currentIndexPath)
        if index < 2 {
            collectionView.setContentOffset(CGPointZero, animated: false)
        } else {
            collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: position, animated: false)
        }
    }
    
    // pragma mark - CollectionViewDelegateWaterfallFlowLayout
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let image = self.images[indexPath.row]
        self.columnWidth =  CGFloat((self.collectionView.collectionViewLayout as CollectionViewWaterfallFlowLayout).columnWidth)
        let imageHeight = image.size.height * self.columnWidth! / image.size.width
        
        // Find the size that the string occupies when displayed with the given font.
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .ByWordWrapping
        var restaurantText: NSString!
        if (Int(indexPath.item)%3 == 0) {
            restaurantText = "RESTAURANTRESTAURANT \(indexPath.item)";
        } else if (Int(indexPath.item)%3 == 1) {
            restaurantText = "RESTAURANT NAME RESTAURANT NAME \(indexPath.item)"
        } else {
            restaurantText = "RESTAURANT"
        }
    
        let restaurantBoundingSize = restaurantText.boundingRectWithSize(CGSizeMake(self.columnWidth! - 65, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size:12)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
        var cuisinetext: NSString!
        if (Int(indexPath.item)%3 == 0) {
            cuisinetext = "CUISINE NAME\(indexPath.item)";
        } else if (Int(indexPath.item)%3 == 1) {
            cuisinetext = "CUISINE NAME CUISINE NAME \(indexPath.item)"
        } else {
            cuisinetext = "CUISINE NAME CUISINE NAME CUISINE NAME CUISINE NAME \(indexPath.item)"
        }
        
        let cuisineBoundingSize = cuisinetext.boundingRectWithSize(CGSizeMake(self.columnWidth! - 20, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Light", size:12)!, NSParagraphStyleAttributeName: paraStyle], context: nil)

        let itemSize = CGSizeMake(self.columnWidth!, max(40, ceil(restaurantBoundingSize.height)) + imageHeight + ceil(cuisineBoundingSize.height) + 42)
        return itemSize
    }
    
    func generateDiscoverDetailViewLayout() -> UICollectionViewFlowLayout {
        let discoverDetailLayout = UICollectionViewFlowLayout()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height

        discoverDetailLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - statusBarHeight - navigationBarHeight!)
        discoverDetailLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        discoverDetailLayout.minimumLineSpacing = 0
        discoverDetailLayout.minimumInteritemSpacing = 0
        discoverDetailLayout.scrollDirection = .Horizontal
        return discoverDetailLayout
    }
    
    func handleTapImage(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }
        let point = tap.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
            let discoverDetailViewController = DiscoverDetailViewController(collectionViewLayout: generateDiscoverDetailViewLayout(), currentIndexPath:indexPath)
            discoverDetailViewController.images = self.images
            self.collectionView.setToIndexPath(indexPath)
            self.navigationController!.pushViewController(discoverDetailViewController, animated: true)
        }
    }
    
    func handleTapRestaurant(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }
        let point = tap.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
//            let menuViewController = MenuViewController()
//            self.navigationController!.pushViewController(menuViewController, animated: true)
            
            let restaurantLayout: CollectionViewStickyHeaderLayout = CollectionViewStickyHeaderLayout()
            restaurantLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            restaurantLayout.minimumLineSpacing = 1
            restaurantLayout.minimumInteritemSpacing = 0
            self.navigationController!.pushViewController(RestaurantViewController(collectionViewLayout: restaurantLayout), animated: true)
        }
    }
    
    func handleLongPress(longPress: UILongPressGestureRecognizer) {
        if (longPress.state != .Ended) {
            return
        }
        let point = longPress.locationInView(self.collectionView)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(point) {
            let discoverCell = self.collectionView.cellForItemAtIndexPath(indexPath) as? DiscoverViewCell
            self.images[indexPath.row] = self.images[0]
            discoverCell!.cuisineImage.image = self.images[0]
            self.collectionView.reloadItemsAtIndexPaths([indexPath])
        }
    }
    
    func mapPressed() -> Void {
        if (isMapShowing == false) {
            isMapShowing = true
            
            UIView.transitionWithView(self.view, duration: 0.5, options: .TransitionFlipFromRight, animations: {
                self.collectionView.removeFromSuperview()
                }, completion: nil)
            
            self.view.addSubview(self.mapView)
            var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "mapView": self.mapView]
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[mapView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[mapView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
            
            var rightButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            rightButton.setImage(UIImage(named: "list.png"), forState: UIControlState.Normal)
            rightButton.frame = CGRectMake(0.0, 0.0, 50, 50);
            rightButton.addTarget(self, action: "mapPressed", forControlEvents: UIControlEvents.TouchUpInside)
            let rightBarButton = UIBarButtonItem.init(customView: rightButton)
            let rightNegativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
            rightNegativeSpacer.width = -15
            self.navigationItem.rightBarButtonItems = [rightNegativeSpacer, rightBarButton]
            
            self.center = self.userLocation.location.coordinate
            let span = MKCoordinateSpanMake(0.15, 0.15)
            self.mapView.mapView.setRegion(MKCoordinateRegion(center: self.center!, span: span), animated: false)
            
            let annotation1 = MKPointAnnotation()
            annotation1.setCoordinate(CLLocationCoordinate2D(latitude: 47.620690, longitude: -122.349266))
            annotation1.title = "Space Needle"
            
            let annotation2 = MKPointAnnotation()
            annotation2.setCoordinate(CLLocationCoordinate2D(latitude: 47.655541, longitude: -122.303445))
            annotation2.title = "University of Washington"
            self.mapView.mapView.addAnnotations([annotation1, annotation2])
            
            self.mapView.mapView.selectAnnotation(annotation1, animated: false)
        } else {
            isMapShowing = false
            UIView.transitionWithView(self.view, duration: 0.5, options: .TransitionFlipFromRight, animations: {
                self.mapView.removeFromSuperview()
                }, completion: nil)
            self.view.addSubview(self.collectionView)
            autoLayoutSubviews()
            var rightButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            rightButton.setImage(UIImage(named: "map.png"), forState: UIControlState.Normal)
            rightButton.frame = CGRectMake(0.0, 0.0, 50, 50);
            rightButton.addTarget(self, action: "mapPressed", forControlEvents: UIControlEvents.TouchUpInside)
            let rightBarButton = UIBarButtonItem.init(customView: rightButton)
            let rightNegativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
            rightNegativeSpacer.width = -15
            self.navigationItem.rightBarButtonItems = [rightNegativeSpacer, rightBarButton]
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation anotacion: MKAnnotation!) -> MKAnnotationView! {
        if !(anotacion is MKPointAnnotation) {
            return nil
        }
        let reusarId = "anotacion"
        var anotacionView = mapView.dequeueReusableAnnotationViewWithIdentifier(reusarId)
        if anotacionView == nil {
            anotacionView = MKAnnotationView(annotation: anotacion, reuseIdentifier: reusarId)
            anotacionView.image = UIImage(named:"pin_red.png")
            anotacionView.canShowCallout = false
        }
        else {
            anotacionView.annotation = anotacion
        }
        
        return anotacionView
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        
        if !view.annotation.isKindOfClass(MKUserLocation) {
//           view.image = UIImage(named:"pin_selected.png")
            self.mapView.restaurantName.text = "RESTAURANT @ \(view.annotation.title!)"
            self.mapView.logoView.image = UIImage(named: "logo.png")
            self.mapView.detailView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Left, animated: true)
        }
    }
    
//    func mapView(mapView: MKMapView!,didDeselectAnnotationView view: MKAnnotationView!) {
//        if !view.annotation.isKindOfClass(MKUserLocation) {
//            view.image = UIImage(named:"pin.png")
//        }
//    }
//    
    func leftButtonPressed() -> Void {
        self.navigationDelegate.interactiveTransition  = nil
        self.navigationController!.pushViewController(FilterViewController(), animated: true)
    }
    
    func scanPressed() -> Void {
        (self.navigationController! as DiscoverNavigationController).pullDownAndUpNavigationBar()
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "collectionView": self.collectionView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}