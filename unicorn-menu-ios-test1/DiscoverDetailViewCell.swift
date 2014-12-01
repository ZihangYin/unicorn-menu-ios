//
//  DiscoverDetailViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverDetailTableViewCell : UICollectionReusableView {
    
    var cuisineImage = UIImageView()
    var cuisineNameLabel = UILabel()
    private var cuisineLikesLogo = UIImageView(image: UIImage(named: "liked.png"))
    var cuisineLikesLabel = UILabel()
    var cuisinePriceLabel = UILabel()
    private var logoView = UIImageView(image: UIImage(named: "logo.png"))
    var restaurantName = UILabel()
    private var bottomBorderForCuisineName = UIView()
    var restaurantView = UIView()
    
    //    private var bottomBorderForRestaurantName = UIView()
    
    private var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                cuisineImage.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                cuisineImage.addConstraint(aspectConstraint!)
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGrayColor()
        
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.cuisineImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineImage.clipsToBounds = true
        
        self.cuisineNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 24)
        self.cuisineNameLabel.textAlignment = .Left
        self.cuisineNameLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        self.cuisineNameLabel.numberOfLines = 10
        self.cuisineNameLabel.lineBreakMode = .ByWordWrapping
        self.cuisineNameLabel.textColor = UIColor.whiteColor()
        
        self.cuisineLikesLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLogo.clipsToBounds = true
        
        self.cuisineLikesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
        self.cuisineLikesLabel.textAlignment = .Center
        self.cuisineLikesLabel.textColor = UIColor.whiteColor()
        
        self.cuisinePriceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisinePriceLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
        self.cuisinePriceLabel.textAlignment = .Left
        self.cuisinePriceLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        self.cuisinePriceLabel.numberOfLines = 20
        self.cuisinePriceLabel.lineBreakMode = .ByWordWrapping
        self.cuisinePriceLabel.textColor = UIColor.whiteColor()
        
        self.bottomBorderForCuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bottomBorderForCuisineName.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        self.logoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoView.clipsToBounds = true
        
        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.numberOfLines = 10
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 12)
        self.restaurantName.textAlignment = .Center
        self.restaurantName.lineBreakMode = .ByWordWrapping
        self.restaurantName.textColor = UIColor.whiteColor()
        
//        self.bottomBorderForRestaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.bottomBorderForRestaurantName.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        self.restaurantView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantView.addSubview(logoView)
        self.restaurantView.addSubview(restaurantName)
//        self.restaurantView.addSubview(bottomBorderForRestaurantName)
        
        self.addSubview(cuisineImage)
        self.addSubview(cuisineNameLabel)
        self.addSubview(cuisineLikesLogo)
        self.addSubview(cuisineLikesLabel)
        self.addSubview(cuisinePriceLabel)
        self.addSubview(bottomBorderForCuisineName)
        self.addSubview(restaurantView)
        
        autoLayoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
        
    }
    
    func setCuisineImage(image: UIImage) {
        let aspect = image.size.width / image.size.height
        aspectConstraint = NSLayoutConstraint(item: cuisineImage, attribute: .Width, relatedBy: .Equal, toItem: cuisineImage, attribute: .Height, multiplier: aspect, constant: 0.0)
        cuisineImage.image = image
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["cuisineImage": self.cuisineImage, "cuisineNameLabel": self.cuisineNameLabel, "bottomBorderForCuisineName": self.bottomBorderForCuisineName, "cuisineLikesLogo": self.cuisineLikesLogo, "cuisineLikesLabel": self.cuisineLikesLabel,
            "cuisinePriceLabel": self.cuisinePriceLabel, "restaurantView": self.restaurantView, "logoView": self.logoView, "restaurantName": self.restaurantName]
        
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cuisineLikesLogo(30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[cuisineLikesLogo(30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.bottomBorderForCuisineName.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomBorderForCuisineName(1)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
//        self.bottomBorderForRestaurantName.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomBorderForRestaurantName(1)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[logoView]-10-[restaurantName]-0-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.logoView, attribute: .CenterX, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterX, multiplier: 1, constant: 0))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.restaurantName, attribute: .CenterX, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterX, multiplier: 1, constant: 0))
//        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.bottomBorderForRestaurantName, attribute: .Width, relatedBy: .Equal, toItem: self.restaurantView, attribute: .Width, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.cuisineImage, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.bottomBorderForCuisineName, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineNameLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.restaurantView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.cuisinePriceLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLogo, attribute: .Right, relatedBy: .Equal, toItem: self.cuisineLikesLabel, attribute: .Left, multiplier: 1, constant: 2.5))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.cuisineLikesLogo, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cuisineImage]-10-[cuisineNameLabel]-10-[cuisineLikesLabel]-10-[cuisinePriceLabel]-10-[bottomBorderForCuisineName]-10-[restaurantView]-10-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }

}

class DiscoverDetailCollectionViewCell: UICollectionViewCell, CollectionViewDelegateWaterfallFlowLayout, UICollectionViewDataSource {
    
    var cuisineImage: UIImage?
    var cuisineName: String?
    var restaurantName: String?
    var cuisineLikes: String?
    var pulledAction: ((offset : CGPoint) -> Void)?
    var tappedAction: (() -> Void)?
    var collectionView: UICollectionView!

    lazy var images: [UIImage] = {
        var _images = [UIImage]()
        for index in 31 ... 39 {
            let imageName = String(format: "dish%02ld.jpg", index)
            _images.append(UIImage(named: imageName)!)
        }
        return _images
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.collectionView.contentOffset = CGPointMake(0, 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let collectionViewLayout: CollectionViewWaterfallFlowLayout = CollectionViewWaterfallFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLayout.columnCount = 2
        collectionViewLayout.minimumColumnSpacing = 7
        collectionViewLayout.minimumInteritemSpacing = 7
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionViewLayout)
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.registerClass(DiscoverRelatedViewCell.self, forCellWithReuseIdentifier: "DiscoverRelatedViewCell")
        self.collectionView!.registerClass(DiscoverDetailTableViewCell.self, forSupplementaryViewOfKind: CollectionViewWaterfallFlowLayoutElementKindSectionHeader, withReuseIdentifier: "DiscoverHeader")
        self.collectionView.backgroundColor = UIColor.darkGrayColor()
        self.collectionView.directionalLockEnabled = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.contentView.addSubview(collectionView)
        self.autoLayoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var discoverCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("DiscoverRelatedViewCell", forIndexPath: indexPath) as DiscoverRelatedViewCell
        let columnWidth =  CGFloat((self.collectionView.collectionViewLayout as CollectionViewWaterfallFlowLayout).columnWidth)
        
        discoverCell.cuisineName.text = "CUISINE NAME \(indexPath.item)"
        discoverCell.cuisineName.preferredMaxLayoutWidth = columnWidth - 40
        
        discoverCell.setCuisineImage(images[indexPath.item])
        discoverCell.cuisineLikesLabel.text = String(500 - indexPath.item)
        
        discoverCell.setNeedsLayout()
        return discoverCell
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let image = images[indexPath.item]
        let columnWidth =  CGFloat((self.collectionView.collectionViewLayout as CollectionViewWaterfallFlowLayout).columnWidth)
        let imageHeight = image.size.height * columnWidth / image.size.width
        
        // Find the size that the string occupies when displayed with the given font.
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .ByWordWrapping
        let cuisinetext = "CUISINE NAME \(indexPath.item)" as NSString
        let cuisineBoundingSize = cuisinetext.boundingRectWithSize(CGSizeMake(columnWidth - 20, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Light", size:12)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
        let itemSize = CGSizeMake(columnWidth, imageHeight + ceil(cuisineBoundingSize.height) + 30)
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView! = nil
        if (kind == CollectionViewWaterfallFlowLayoutElementKindSectionHeader) {
            var discoverDetailTableViewCell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "DiscoverHeader", forIndexPath: indexPath) as DiscoverDetailTableViewCell
            
            discoverDetailTableViewCell.setCuisineImage(cuisineImage!)
            discoverDetailTableViewCell.cuisineNameLabel.text = "\(cuisineName!)"
            discoverDetailTableViewCell.cuisinePriceLabel.text = "$ 25.00"
            discoverDetailTableViewCell.restaurantName.text = restaurantName!
            discoverDetailTableViewCell.cuisineLikesLabel.text = cuisineLikes!

            let tapRestaurantLogo = UITapGestureRecognizer.init(target: self, action: "handleTapRestaurant:")
            discoverDetailTableViewCell.restaurantView.addGestureRecognizer(tapRestaurantLogo)
            
            reusableView = discoverDetailTableViewCell
            reusableView.setNeedsLayout()
        }
        
        return reusableView
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, heightForHeaderInSection section: Int) -> Float {
        if (section == 0) {
            let imageHeight =  Float(cuisineImage!.size.height * collectionView.frame.width / cuisineImage!.size.width)
            
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.lineBreakMode = .ByWordWrapping
            let restaurantText = restaurantName!
            let restaurantBoundingSize = restaurantText.boundingRectWithSize(CGSizeMake(collectionView.frame.width, CGFloat.max), options: .UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size:18)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
            let cuisinetext = cuisineName!
            let cuisineBoundingSize = cuisinetext.boundingRectWithSize(CGSizeMake(collectionView.frame.width, CGFloat.max), options: .UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size:24)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
            
            let itemSize = Float(ceil(restaurantBoundingSize.height)) + imageHeight +  Float(ceil(cuisineBoundingSize.height)) + 150.0
            return itemSize
            
        }
        return 0.0
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -80 {
            pulledAction?(offset: scrollView.contentOffset)
        }
    }
    
    func handleTapRestaurant(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }
        tappedAction?()
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["collectionView": self.collectionView]
        let tableView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let tableView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.addConstraints(tableView_constraint_H)
        self.addConstraints(tableView_constraint_V)
    }
}
