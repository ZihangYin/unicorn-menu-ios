//
//  MapDetailView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/7/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView, UICollectionViewDataSource {

    var mapView: MKMapView!
    var refreshView = UIImageView()
    var logoView = UIImageView()
    var restaurantName = UILabel()
    var detailView: UICollectionView!
    private var restaurantInfoView = UIView()
    private var expandCollapseView = UIImageView(image: UIImage(named: "down.png"))
    private var showDetail = false
    
    lazy var images: [UIImage] = {
        var _images = [UIImage]()
        for index in 33 ... 39 {
            let imageName = String(format: "dish%02ld.jpg", index)
            _images.append(UIImage(named: imageName)!)
        }
        return _images
        }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.logoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoView.clipsToBounds = true
        
        let logoLayer = self.logoView.layer
        logoLayer.cornerRadius = 20
        logoLayer.borderWidth = 1
        logoLayer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).CGColor
        logoLayer.masksToBounds = true
        
        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 16)
        self.restaurantName.numberOfLines = 2
        self.restaurantName.textAlignment = .Left
        self.restaurantName.lineBreakMode = .ByTruncatingTail
        self.restaurantName.textColor = UIColor.blackColor()
        
        self.expandCollapseView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.expandCollapseView.clipsToBounds = true
        
        self.restaurantInfoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantInfoView.backgroundColor = UIColor.grayColor()
        self.restaurantInfoView.addSubview(self.logoView)
        self.restaurantInfoView.addSubview(self.restaurantName)
        self.restaurantInfoView.addSubview(self.expandCollapseView)
        
        self.refreshView.image = UIImage(named: "refresh.png")
        self.refreshView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.refreshView.clipsToBounds = true
        
        self.mapView = MKMapView(frame: CGRectZero)
        self.mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mapView.showsBuildings = false
        self.mapView.showsPointsOfInterest = false
        self.mapView.showsUserLocation = true
        
        self.mapView.addSubview(self.refreshView)
        
        var detailViewLayout = UICollectionViewFlowLayout()
        detailViewLayout.itemSize = CGSizeMake(100, 100)
        detailViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        detailViewLayout.minimumLineSpacing = 1
        detailViewLayout.minimumInteritemSpacing = 0
        detailViewLayout.scrollDirection = .Horizontal

        self.detailView = UICollectionView(frame: CGRectZero, collectionViewLayout: detailViewLayout)
        self.detailView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.detailView.dataSource = self
        self.detailView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "DetailViewCell")
        self.detailView.backgroundColor = UIColor.grayColor()
        self.detailView.directionalLockEnabled = true
        self.detailView.showsHorizontalScrollIndicator = false
        
        self.insertSubview(self.restaurantInfoView, atIndex: 2)
        self.insertSubview(self.mapView, atIndex: 0)

        autoLayoutSubviews()
        
        self.restaurantInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTapExpandCollapseView:"))
    }
     
    func handleTapExpandCollapseView(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }
        
        if showDetail {
            UIView.animateWithDuration(0.35, delay: 0.0, options: .CurveEaseIn, animations: {
                self.detailView.transform = CGAffineTransformMakeTranslation(0, -100)
                self.detailView.alpha = 0.0
                self.expandCollapseView.image = UIImage(named: "down.png")
                }, completion: {(Bool) in
                    self.detailView.removeFromSuperview()
                    self.detailView.transform = CGAffineTransformIdentity
            })
        } else {
            self.detailView.alpha = 0.0
            self.insertSubview(self.detailView, atIndex: 1)
            var viewsDictionary = ["restaurantInfoView": self.restaurantInfoView, "detailView": self.detailView]
            self.detailView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[detailView(100)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[detailView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
            self.addConstraint(NSLayoutConstraint(item: self.detailView, attribute: .Top, relatedBy: .Equal, toItem: self.restaurantInfoView, attribute: .Bottom, multiplier: 1, constant: 0))
            self.detailView.transform = CGAffineTransformMakeTranslation(0, -100)
            
            UIView.animateWithDuration(0.35, delay: 0.0, options: .CurveEaseOut, animations: {
                self.detailView.transform = CGAffineTransformIdentity
                self.detailView.alpha = 1
                self.expandCollapseView.image = UIImage(named: "up@3x.png")
                }, completion: nil)
        }
        showDetail = !showDetail
    }
    
    // pragma mark - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailViewCell", forIndexPath: indexPath) as UICollectionViewCell
        var imageView = UIImageView(image: self.images[indexPath.item])
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        cell.backgroundView = imageView
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["mapView": self.mapView, "refreshView": self.refreshView, "restaurantInfoView": self.restaurantInfoView, "logoView": self.logoView,
            "restaurantName": self.restaurantName, "expandCollapseView": self.expandCollapseView, "detailView": self.detailView]
    
        
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.expandCollapseView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[expandCollapseView(10)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.expandCollapseView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[expandCollapseView(10)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.refreshView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[refreshView(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.refreshView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[refreshView(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.restaurantInfoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[logoView]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantInfoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[restaurantName]-5-[expandCollapseView]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantInfoView.addConstraint(NSLayoutConstraint(item: self.restaurantName, attribute: .Left, relatedBy: .Equal, toItem: self.logoView, attribute: .Right, multiplier: 1, constant: 10))
        self.restaurantInfoView.addConstraint(NSLayoutConstraint(item: self.restaurantName, attribute: .CenterY, relatedBy: .Equal, toItem: self.restaurantInfoView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.restaurantInfoView.addConstraint(NSLayoutConstraint(item: self.logoView, attribute: .CenterY, relatedBy: .Equal, toItem: self.restaurantInfoView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.restaurantInfoView.addConstraint(NSLayoutConstraint(item: self.expandCollapseView, attribute: .CenterY, relatedBy: .Equal, toItem: self.restaurantInfoView, attribute: .CenterY, multiplier: 1, constant: 0))

        self.mapView.addConstraint(NSLayoutConstraint(item: self.refreshView, attribute: .CenterX, relatedBy: .Equal, toItem: self.mapView, attribute: .CenterX, multiplier: 1, constant: 0))
        self.mapView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[refreshView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantInfoView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[mapView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[restaurantInfoView(50)]-0-[mapView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
 //       self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[restaurantInfoView(50)]-0-[detailView(100)]-0-[mapView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))

    }
}
