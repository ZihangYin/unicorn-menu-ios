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
    var cuisineImage = UIImageView()
    var restaurantName = UILabel()
    var cuisineName = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor =  UIColor.grayColor()
        
        self.logoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoView.userInteractionEnabled = true
        self.logoView.clipsToBounds = true
     
        self.cuisineImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineImage.userInteractionEnabled = true
        self.cuisineImage.clipsToBounds = true
        
        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.userInteractionEnabled = true
        self.restaurantName.numberOfLines = 10
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 12)
        self.restaurantName.textAlignment = .Center
        self.restaurantName.lineBreakMode = .ByWordWrapping
        self.restaurantName.textColor = UIColor.whiteColor()
        
        self.cuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineName.numberOfLines = 10
        self.cuisineName.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.cuisineName.textAlignment = .Center
        self.cuisineName.lineBreakMode = .ByWordWrapping
        self.cuisineName.textColor = UIColor.whiteColor()
        
        contentView.addSubview(logoView)
        contentView.addSubview(cuisineImage)
        contentView.addSubview(restaurantName)
        contentView.addSubview(cuisineName)
        
        autoLayoutSubviews()
    }
    
    // pragma mark - DiscoverTansitionViewCellProtocol
    func snapShotForDiscoverTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.cuisineImage.image)
        snapShotView.frame = self.cuisineImage.frame
        return snapShotView
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["logoView": self.logoView, "restaurantName": self.restaurantName, "cuisineImage": self.cuisineImage, "cuisineName": self.cuisineName]
        let logoView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[logoView(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let logoView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[logoView(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.logoView.addConstraints(logoView_constraint_H)
        self.logoView.addConstraints(logoView_constraint_V)
        
        let restaurant_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[restaurantName]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let cuisineName_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[cuisineName]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let cuisineImage_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cuisineImage]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let logo_constraint_H = NSLayoutConstraint(item: self.logoView, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1, constant: 0)
        let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cuisineImage]-5-[cuisineName]-5-[logoView]-5-[restaurantName]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)

        self.addConstraints(restaurant_constraint_H)
        self.addConstraints(cuisineName_constraint_H)
        self.addConstraints(cuisineImage_constraint_H)
        self.addConstraint(logo_constraint_H)
        self.addConstraints(view_constraint_V)
    }
}
