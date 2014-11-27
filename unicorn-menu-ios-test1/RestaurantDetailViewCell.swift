//
//  RestaurantDetailViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/25/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class RestaurantDetailForegroundView: UIView {
    
    var cuisineName: UILabel!
    var cuisineDescriptionBox: UIView!
    var cuisineDescription: UILabel!
    var cuisineIngredientsBox: UIView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.cuisineName = UILabel(frame:CGRectMake(5, 5, 310, 120))
        self.cuisineName = UILabel()
        self.cuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineName.font = UIFont(name: "ProximaNova-Bold", size: 40)
        self.cuisineName.textAlignment = .Left
        self.cuisineName.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        self.cuisineName.numberOfLines = 10
        self.cuisineName.lineBreakMode = .ByWordWrapping
        self.cuisineName.shadowColor = UIColor.blackColor()
        self.cuisineName.shadowOffset = CGSizeMake(1, 1)
        
//        self.cuisineDescriptionBox = UIView(frame: CGRectMake(5, 60, 310, 120))
        self.cuisineDescriptionBox = UIView()
        self.cuisineDescriptionBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineDescriptionBox.layer.cornerRadius = 3;
        self.cuisineDescriptionBox.backgroundColor = UIColor(white: 0, alpha: 0.15)
        
//        self.cuisineDescription = UILabel(frame: CGRectMake(5, 60, 310, 120))
        self.cuisineDescription = UILabel()
        self.cuisineDescription.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineDescription.font = UIFont(name: "ProximaNova-Regualr", size: 24)
        self.cuisineDescription.textAlignment = .Left
        self.cuisineDescription.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        self.cuisineDescription.numberOfLines = 20
        self.cuisineDescription.lineBreakMode = .ByWordWrapping
        
//        self.cuisineIngredientsBox = UIView(frame: CGRectMake(5, 200, 310, 300))
        self.cuisineIngredientsBox = UIView()
        self.cuisineIngredientsBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineIngredientsBox.layer.cornerRadius = 3;
        self.cuisineDescriptionBox.backgroundColor = UIColor(white: 0, alpha: 0.15)
        
        self.addSubview(cuisineName)
        self.addSubview(cuisineDescriptionBox)
        self.addSubview(cuisineDescription)
        self.addSubview(cuisineIngredientsBox)
        
        var viewsDictionary = ["cuisineName": self.cuisineName, "cuisineDescriptionBox": self.cuisineDescriptionBox, "cuisineDescription": self.cuisineDescription, "cuisineIngredientsBox": self.cuisineIngredientsBox]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[cuisineName]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[cuisineDescriptionBox]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[cuisineDescription]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[cuisineIngredientsBox]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineDescriptionBox, attribute: .CenterY, relatedBy: .Equal, toItem: self.cuisineDescription, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.cuisineDescriptionBox, attribute: .Height, relatedBy: .Equal, toItem: self.cuisineDescription, attribute: .Height, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[cuisineName]-20-[cuisineDescription]-10-[cuisineIngredientsBox]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
    
}


class RestaurantDetailViewCell: UICollectionViewCell {

    var cuisineDetailView: CuisineDetailView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.backgroundColor = UIColor.darkGrayColor()
        cuisineDetailView = CuisineDetailView(frame: self.frame)
        cuisineDetailView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(cuisineDetailView)
    }
}
