//
//  CollectionViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/8/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@objc protocol DiscoverTansitionViewCellProtocol{
    func snapShotForDiscoverTransition() -> UIImageView!
}

class DiscoverViewCell: UICollectionViewCell, DiscoverTansitionViewCellProtocol {
    
    var logoView = UIImageView()
    var cuisineImage = UIImageView()
    var restaurantName = UILabel()
    var cuisineName = UILabel()
    var restaurantView = UIView()
    var cuisineLikesLogo = UIImageView(image: UIImage(named: "heart.png"))
    var cuisineLikesLabel = UILabel()
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
        
        self.backgroundColor =  UIColor.whiteColor()
        
        self.logoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoView.clipsToBounds = true
        
        let logoLayer = self.logoView.layer
        logoLayer.cornerRadius = 20
        logoLayer.borderWidth = 1
        logoLayer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).CGColor
        logoLayer.masksToBounds = true
     
        self.cuisineImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineImage.userInteractionEnabled = true
        self.cuisineImage.clipsToBounds = true
    
        self.cuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineName.numberOfLines = 10
        self.cuisineName.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.cuisineName.textAlignment = .Left
        self.cuisineName.lineBreakMode = .ByWordWrapping
        self.cuisineName.textColor = UIColor.darkGrayColor()
        
        self.cuisineLikesLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLogo.clipsToBounds = true
        
        self.cuisineLikesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLabel.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.cuisineLikesLabel.textAlignment = .Left
        self.cuisineLikesLabel.textColor = UIColor.darkGrayColor()

        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.numberOfLines = 10
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 12)
        self.restaurantName.textAlignment = .Left
        self.restaurantName.lineBreakMode = .ByWordWrapping
        self.restaurantName.textColor = UIColor.blackColor()
        
        self.restaurantView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantView.addSubview(logoView)
        self.restaurantView.addSubview(restaurantName)
        
        contentView.addSubview(cuisineImage)
        contentView.addSubview(cuisineName)
        contentView.addSubview(restaurantView)
        contentView.addSubview(cuisineLikesLogo)
        contentView.addSubview(cuisineLikesLabel)
        
        autoLayoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func setCuisineImage(imageName: String) {
        var image = UIImage(named: imageName)!
        let aspect = image.size.width / image.size.height
        aspectConstraint = NSLayoutConstraint(item: cuisineImage, attribute: .Width, relatedBy: .Equal, toItem: cuisineImage, attribute: .Height, multiplier: aspect, constant: 0.0)
        self.cuisineImage.image = image
    }
    
    // pragma mark - DiscoverTansitionViewCellProtocol
    func snapShotForDiscoverTransition() -> UIImageView! {
        let snapShotView = UIImageView(image: self.cuisineImage.image)
        snapShotView.frame = self.cuisineImage.frame
        return snapShotView
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["logoView": self.logoView, "restaurantName": self.restaurantName, "cuisineImage": self.cuisineImage, "cuisineName": self.cuisineName,
            "restaurantView": self.restaurantView, "cuisineLikesLogo": self.cuisineLikesLogo, "cuisineLikesLabel": self.cuisineLikesLabel]
        
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
//        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[restaurantName]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
//        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.logoView, attribute: .CenterX, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterX, multiplier: 1, constant: 0))
//        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[logoView]-5-[restaurantName]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))

        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[logoView]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.restaurantName, attribute: .Left, relatedBy: .Equal, toItem: self.logoView, attribute: .Right, multiplier: 1, constant: 5))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.restaurantName, attribute: .CenterY, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.logoView, attribute: .CenterY, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterY, multiplier: 1, constant: 0))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.restaurantView, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: self.restaurantName, attribute: .Height, multiplier: 1, constant: 0))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.restaurantView, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: self.logoView, attribute: .Height, multiplier: 1, constant: 0))

        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[cuisineName]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cuisineImage]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-7-[cuisineLikesLogo]-0-[cuisineLikesLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.cuisineLikesLogo, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[restaurantView]-5-[cuisineImage]-5-[cuisineName]-0-[cuisineLikesLogo]",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}

class DiscoverRelatedViewCell: UICollectionViewCell, DiscoverTansitionViewCellProtocol {
    
    var cuisineImage = UIImageView()
    var cuisineName = UILabel()
    var cuisineLikesLogo = UIImageView(image: UIImage(named: "heart.png"))
    var cuisineLikesLabel = UILabel()
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
        
        self.backgroundColor =  UIColor.whiteColor()
        
        self.cuisineImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineImage.userInteractionEnabled = true
        self.cuisineImage.clipsToBounds = true
        
        self.cuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineName.numberOfLines = 10
        self.cuisineName.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.cuisineName.textAlignment = .Left
        self.cuisineName.lineBreakMode = .ByWordWrapping
        self.cuisineName.textColor = UIColor.blackColor()
        
        self.cuisineLikesLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLogo.clipsToBounds = true
        
        self.cuisineLikesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLabel.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.cuisineLikesLabel.textAlignment = .Left
        self.cuisineLikesLabel.textColor = UIColor.blackColor()
        
        contentView.addSubview(cuisineImage)
        contentView.addSubview(cuisineName)
        contentView.addSubview(cuisineLikesLogo)
        contentView.addSubview(cuisineLikesLabel)
        
        autoLayoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func setCuisineImage(imageName: String) {
        var image = UIImage(named: imageName)!
        let aspect = image.size.width / image.size.height
        aspectConstraint = NSLayoutConstraint(item: cuisineImage, attribute: .Width, relatedBy: .Equal, toItem: cuisineImage, attribute: .Height, multiplier: aspect, constant: 0.0)
        self.cuisineImage.image = image
    }
    
    // pragma mark - DiscoverTansitionViewCellProtocol
    func snapShotForDiscoverTransition() -> UIImageView! {
        let snapShotView = UIImageView(image: self.cuisineImage.image)
        snapShotView.frame = self.cuisineImage.frame
        return snapShotView
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["cuisineImage": self.cuisineImage, "cuisineName": self.cuisineName, "cuisineLikesLogo": self.cuisineLikesLogo, "cuisineLikesLabel": self.cuisineLikesLabel]
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
       
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[cuisineName]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cuisineImage]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-7-[cuisineLikesLogo]-0-[cuisineLikesLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.cuisineLikesLogo, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cuisineImage]-10-[cuisineName]-0-[cuisineLikesLogo]",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}

