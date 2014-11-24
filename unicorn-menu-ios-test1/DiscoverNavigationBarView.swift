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
        self.scanButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.scanButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.scanButton.setImage(UIImage(named: "scan.png"), forState: UIControlState.Normal);
        self.addSubview(scanButton);
    }
    
    private func autoLayoutSubviews() {
        
        var viewsDictionary = ["scanButton": self.scanButton]
        let scanButton_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[scanButton(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let scanButton_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[scanButton(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let scanButton_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[scanButton]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let scanButton_pos_constraint_V = NSLayoutConstraint(item: self.scanButton,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant: 2)
        
        self.scanButton.addConstraints(scanButton_constraint_H)
        self.scanButton.addConstraints(scanButton_constraint_V)
        self.addConstraints(scanButton_pos_constraint_H)
        self.addConstraint(scanButton_pos_constraint_V)
    }
    
    private func addGradientColor() {
        self.gradientLayer.colors = [UIColor.blackColor().CGColor, UIColor.darkGrayColor().CGColor]
        self.gradientLayer.opacity = 1.0
    }
}
