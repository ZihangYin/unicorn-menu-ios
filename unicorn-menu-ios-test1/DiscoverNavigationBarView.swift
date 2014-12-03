//
//  NavView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/9/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverNavigationBarView: UINavigationBar {
    
    var scanButton: UIButton!
//    private var gradientLayer = CAGradientLayer()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let shadow = NSShadow()
//        shadow.shadowOffset = CGSizeMake(1, 1)
//        shadow.shadowBlurRadius = 1
//        shadow.shadowColor = UIColor.blackColor()
//        self.titleTextAttributes = [NSFontAttributeName: UIFont(name: "ProximaNova-Regular", size:17)!, NSShadowAttributeName: shadow]
        
        self.translucent = false
        self.barStyle = .Black
        self.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.shadowImage = UIImage()
        
        self.barTintColor = UIColor.redColor()
        self.titleTextAttributes = [NSFontAttributeName: UIFont(name: "ProximaNova-Regular", size:17)!]
        
        setupViews()
        autoLayoutSubviews()
//        addGradientColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height;
 //       self.gradientLayer.frame = CGRect(x: self.bounds.origin.x, y:self.bounds.origin.y - statusBarHeight, width: self.bounds.width, height: self.bounds.height + statusBarHeight)
 //       self.layer.insertSublayer(gradientLayer, atIndex: 1);
    }
    
    private func setupViews() {
        self.scanButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.scanButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scanButton.setImage(UIImage(named: "barcode.png"), forState: UIControlState.Normal);
        self.addSubview(scanButton);
    }
    
    private func autoLayoutSubviews() {
        
        var viewsDictionary = ["scanButton": self.scanButton]
        let scanButton_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[scanButton(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let scanButton_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[scanButton(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let scanButton_pos_constraint_H = NSLayoutConstraint(item: self.scanButton,attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1,  constant: 10)
        let scanButton_pos_constraint_V = NSLayoutConstraint(item: self.scanButton,attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1,  constant: 0)
        
        self.scanButton.addConstraints(scanButton_constraint_H)
        self.scanButton.addConstraints(scanButton_constraint_V)
        self.addConstraint(scanButton_pos_constraint_H)
        self.addConstraint(scanButton_pos_constraint_V)
    }
    
    private func addGradientColor() {
//        
//        gradientLayer.anchorPoint = CGPointZero;
//        gradientLayer.startPoint = CGPointMake(0.5, 0.0);
//        gradientLayer.endPoint = CGPointMake(0.5, 1.0);
//        
//        let colors: [AnyObject] = [UIColor(white: 0, alpha: 1.0).CGColor, UIColor(white: 0, alpha: 0.8).CGColor, UIColor(white: 0, alpha: 0.5).CGColor, UIColor(white: 0, alpha: 0.5).CGColor]
//        gradientLayer.colors = colors
//        gradientLayer.locations = [0.0, 0.2, 0.5, 1.0]
//        self.gradientLayer.colors = [UIColor.blackColor().CGColor, UIColor.darkGrayColor().CGColor]
//        self.gradientLayer.opacity = 1.0
    }
}
