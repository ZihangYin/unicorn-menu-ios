//
//  CollectionViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/8/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@objc protocol DiscoverTansitionViewCellProtocol{
    func snapShotForDiscoverTransition() -> UIView!
}

class DiscoverViewCell: UICollectionViewCell, DiscoverTansitionViewCellProtocol {
    
    var logoView = UIImageView()
    var restaurantName = UILabel()
    var imageView = UIImageView()
    var cuisineName = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1
        self.backgroundColor =  UIColor.whiteColor()
        
        self.logoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoView.clipsToBounds = true
        
        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.numberOfLines = 10
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 12)
        self.restaurantName.textAlignment = .Left
        self.restaurantName.lineBreakMode = .ByWordWrapping
        
        self.imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.imageView.clipsToBounds = true
 
        self.cuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineName.numberOfLines = 10
        self.cuisineName.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.cuisineName.textAlignment = .Center
        self.cuisineName.lineBreakMode = .ByWordWrapping
        
        contentView.addSubview(logoView)
        contentView.addSubview(restaurantName)
        contentView.addSubview(imageView)
        contentView.addSubview(cuisineName)
        autoLayoutSubviews()
    }
    
    // pragma mark - DiscoverTansitionViewCellProtocol
    func snapShotForDiscoverTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.imageView.image)
        snapShotView.frame = self.imageView.frame
        return snapShotView
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["logoView": self.logoView, "restaurantName": self.restaurantName, "imageView": self.imageView, "cuisineName": self.cuisineName]
        let logoView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[logoView(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let logoView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[logoView(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.logoView.addConstraints(logoView_constraint_H)
        self.logoView.addConstraints(logoView_constraint_V)
        
        let restaurant_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[logoView]-5-[restaurantName]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let imageView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let cuisineName_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[cuisineName]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let logo_constraint_V = NSLayoutConstraint(item: self.logoView, attribute: .CenterY, relatedBy: .Equal, toItem: self.restaurantName, attribute: .CenterY, multiplier: 1, constant: 0)
        let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[restaurantName]-5-[imageView]-5-[cuisineName]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.addConstraints(restaurant_constraint_H)
        self.addConstraints(imageView_constraint_H)
        self.addConstraints(cuisineName_constraint_H)
        self.addConstraint(logo_constraint_V)
        self.addConstraints(view_constraint_V)
    }
}
