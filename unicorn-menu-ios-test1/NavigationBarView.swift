//
//  NavView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/9/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class NavigationBarView: UINavigationBar {
    
    var leftButton: UIButton!
    var titleIconImageView: UIImageView!
    var title: UILabel!
    var rightButton: UIButton!
    private var gradientLayer = CAGradientLayer()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        self.leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.leftButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.leftButton.setImage(UIImage(named: "scan.png"), forState: UIControlState.Normal)
        self.addSubview(leftButton)
        
        self.titleIconImageView = UIImageView(frame: CGRectZero);
        self.titleIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleIconImageView.image = UIImage(named: "down.png");
        self.addSubview(titleIconImageView);
        
        self.title = UILabel(frame: CGRectZero)
        self.title.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.title.font = UIFont(name: "ProximaNova-Light", size: 17)
        self.title.textAlignment = .Center
        self.title.textColor = UIColor.whiteColor()
        self.title.text = "DISCOVER"
        self.addSubview(title)
        
        self.rightButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.rightButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.rightButton.setImage(UIImage(named: "map.png"), forState: UIControlState.Normal)
        self.addSubview(rightButton)
        
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["leftButton": self.leftButton!, "titleIconImage": self.titleIconImageView, "title": self.title, "rightButton": self.rightButton]
        let leftButton_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[leftButton(45)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let leftButton_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[leftButton(45)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let leftButton_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[leftButton]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let leftButton_pos_constraint_V = NSLayoutConstraint(item: self.leftButton,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)
        
        let rightButton_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[rightButton(45)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let rightButton_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[rightButton(45)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let rightButton_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[rightButton]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let rightButton_pos_constraint_V = NSLayoutConstraint(item: self.rightButton,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)
        
        let titleIconImage_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[titleIconImage(12)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let titleIconImage_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[titleIconImage(12)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let titleIconImage_pos_constraint_H = NSLayoutConstraint(item: self.titleIconImageView,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self.title,
            attribute: .CenterX,
            multiplier: 1,
            constant: 45)
        let titleIconImage_pos_constraint_V = NSLayoutConstraint(item: self.titleIconImageView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)
        
        let text_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[title]-7-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let text_pos_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[title]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.leftButton.addConstraints(leftButton_constraint_H)
        self.leftButton.addConstraints(leftButton_constraint_V)
        self.addConstraints(leftButton_pos_constraint_H)
        self.addConstraint(leftButton_pos_constraint_V)
        self.rightButton.addConstraints(rightButton_constraint_H)
        self.rightButton.addConstraints(rightButton_constraint_V)
        self.addConstraints(rightButton_pos_constraint_H)
        self.addConstraint(rightButton_pos_constraint_V)
        self.titleIconImageView.addConstraints(titleIconImage_constraint_H)
        self.titleIconImageView.addConstraints(titleIconImage_constraint_V)
        self.addConstraint(titleIconImage_pos_constraint_H)
        self.addConstraint(titleIconImage_pos_constraint_V)
        self.addConstraints(text_pos_constraint_H)
        self.addConstraints(text_pos_constraint_V)
    }
    
    private func addGradientColor() {
        var firstColor = UIColor(red:255.0/255.0, green:42.0/255.0, blue:104.0/255.0, alpha:1.0).CGColor
        var secondColor = UIColor(red:255.0/255.0, green:90.0/255.0, blue:58.0/255.0, alpha:1.0).CGColor
        self.gradientLayer.colors = [firstColor, secondColor]
        self.gradientLayer.opacity = 1.0
    }
}
