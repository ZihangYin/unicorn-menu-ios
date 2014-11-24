//
//  NavView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/9/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverNavigationBarView: UINavigationBar {
    
//    var title: UILabel!
//    var filterButton: UIButton!
    private var gradientLayer = CAGradientLayer()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        autoLayoutSubviews()
        addGradientColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height;
        self.gradientLayer.frame = CGRect(x: self.bounds.origin.x, y:self.bounds.origin.y - statusBarHeight, width: self.bounds.width, height: self.bounds.height + statusBarHeight)
        self.layer.insertSublayer(gradientLayer, atIndex: 1);
    }
    
    private func setupViews() {
        
//        self.title = UILabel(frame: CGRectZero)
//        self.title.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.title.font = UIFont(name: "ProximaNova-Light", size: 17)
//        self.title.textAlignment = .Center
//        self.title.textColor = UIColor.whiteColor()  
//        self.addSubview(title)
//
//        self.filterButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        self.filterButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.filterButton.setImage(UIImage(named: "down.png"), forState: UIControlState.Normal);
//        self.addSubview(filterButton);
    }
    
    private func autoLayoutSubviews() {
//        var viewsDictionary = ["filterButton": self.filterButton, "title": self.title]
//        var viewsDictionary = ["title": self.title]
//        
//        let filterButton_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[filterButton(12)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
//        let filterButton_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[filterButton(12)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
//        let filterButton_pos_constraint_H = NSLayoutConstraint(item: self.filterButton, attribute: .Left, relatedBy: .Equal, toItem: self.title, attribute: .CenterX, multiplier: 1, constant: 45)
//        let filterButton_pos_constraint_V = NSLayoutConstraint(item: self.filterButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
//        
//        let text_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-60-[title]-60-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
//        let text_pos_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[title]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
//        
//        self.filterButton.addConstraints(filterButton_constraint_H)
//        self.filterButton.addConstraints(filterButton_constraint_V)
//        self.addConstraint(filterButton_pos_constraint_H)
//        self.addConstraint(filterButton_pos_constraint_V)
//        self.addConstraints(text_pos_constraint_H)
//        self.addConstraints(text_pos_constraint_V)
    }
    
    private func addGradientColor() {
//        var firstColor = UIColor(red:255.0/255.0, green:42.0/255.0, blue:104.0/255.0, alpha:1.0).CGColor
//        var secondColor = UIColor(red:255.0/255.0, green:90.0/255.0, blue:58.0/255.0, alpha:1.0).CGColor
        self.gradientLayer.colors = [UIColor.blackColor().CGColor, UIColor.darkGrayColor().CGColor]
        self.gradientLayer.opacity = 1.0
    }
}
