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
    var bottomBorderForCuisineName = UIView()
    var restaurantView = UIView()
    var cuisineLikesLogo = UIImageView(image: UIImage(named: "liked.png"))
    var cuisineLikesLabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor =  UIColor.grayColor()
        
        self.logoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoView.clipsToBounds = true
     
        self.cuisineImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineImage.userInteractionEnabled = true
        self.cuisineImage.clipsToBounds = true
    
        self.cuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineName.numberOfLines = 10
        self.cuisineName.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.cuisineName.textAlignment = .Center
        self.cuisineName.lineBreakMode = .ByWordWrapping
        self.cuisineName.textColor = UIColor.whiteColor()
        
        self.cuisineLikesLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLogo.clipsToBounds = true
        
        self.cuisineLikesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLabel.font = UIFont(name: "ProximaNova-Light", size: 8)
        self.cuisineLikesLabel.textAlignment = .Center
        self.cuisineLikesLabel.textColor = UIColor.whiteColor()
        
        self.bottomBorderForCuisineName = UIView()
        self.bottomBorderForCuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bottomBorderForCuisineName.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)

        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.numberOfLines = 10
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 12)
        self.restaurantName.textAlignment = .Center
        self.restaurantName.lineBreakMode = .ByWordWrapping
        self.restaurantName.textColor = UIColor.whiteColor()
        
        self.restaurantView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantView.addSubview(logoView)
        self.restaurantView.addSubview(restaurantName)
        
        contentView.addSubview(cuisineImage)
        contentView.addSubview(cuisineName)
        contentView.addSubview(bottomBorderForCuisineName)
        contentView.addSubview(restaurantView)
        contentView.addSubview(cuisineLikesLogo)
        contentView.addSubview(cuisineLikesLabel)
        
        autoLayoutSubviews()
    }
    
    // pragma mark - DiscoverTansitionViewCellProtocol
    func snapShotForDiscoverTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.cuisineImage.image)
        snapShotView.frame = self.cuisineImage.frame
        return snapShotView
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["logoView": self.logoView, "restaurantName": self.restaurantName, "cuisineImage": self.cuisineImage, "cuisineName": self.cuisineName, "bottomBorderForCuisineName": self.bottomBorderForCuisineName,
            "restaurantView": self.restaurantView, "cuisineLikesLogo": self.cuisineLikesLogo, "cuisineLikesLabel": self.cuisineLikesLabel]
        
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoView(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoView(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.bottomBorderForCuisineName.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomBorderForCuisineName(0.5)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[restaurantName]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.logoView, attribute: .CenterX, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterX, multiplier: 1, constant: 0))
        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[logoView]-5-[restaurantName]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[cuisineName]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bottomBorderForCuisineName]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cuisineImage]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLogo, attribute: .Right, relatedBy: .Equal, toItem: self.cuisineLikesLabel, attribute: .Left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.cuisineLikesLogo, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cuisineImage]-5-[cuisineName]-0-[cuisineLikesLogo]-0-[bottomBorderForCuisineName]-4.5-[restaurantView]-5-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}
