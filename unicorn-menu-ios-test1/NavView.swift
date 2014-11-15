//
//  NavView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/9/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class NavView: UINavigationBar {
    
    let gridBtn: UIButton!
    let upImgView: UIImageView!
    let textLabel: UILabel!
    let mapBtn: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        println("frame \(frame)")
        gridBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.gridBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        gridBtn.setImage(UIImage(named: "scan.png"), forState: UIControlState.Normal)
        self.addSubview(gridBtn)
        
        upImgView = UIImageView(frame: CGRectZero);
        self.upImgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        var upImg = UIImage(named: "up.png")
        upImgView.image = upImg;
        self.addSubview(upImgView);
        
        textLabel = UILabel(frame: CGRectZero)
        self.textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
        textLabel.textColor = UIColor.blackColor()
        textLabel.textAlignment = .Center
        textLabel.text = "DISCOVER"
        self.addSubview(textLabel)
        
        mapBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.mapBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        mapBtn.setImage(UIImage(named: "map.png"), forState: UIControlState.Normal)
        self.addSubview(mapBtn)
        
        var viewsDictionary = ["gridBtn": self.gridBtn!, "upImage": self.upImgView, "textLabel": self.textLabel, "mapBtn": self.mapBtn]
        let gridBtn_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[gridBtn(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let gridBtn_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[gridBtn(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let gridBtn_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[gridBtn]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let gridBtn_pos_constraint_V = NSLayoutConstraint(item: self.gridBtn,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)

        
        let mapBtn_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[mapBtn(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let mapBtn_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[mapBtn(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let mapBtn_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[mapBtn]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let mapBtn_pos_constraint_V = NSLayoutConstraint(item: self.mapBtn,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0)
        
        let upImage_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[upImage(15)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let upImage_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[upImage(15)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        let upImage_pos_constraint_H = NSLayoutConstraint(item: self.upImgView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1,
            constant: 0)
        
        let text_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[textLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let upImage_text_pos_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[upImage]-0-[textLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.gridBtn.addConstraints(gridBtn_constraint_H)
        self.gridBtn.addConstraints(gridBtn_constraint_V)
        self.addConstraints(gridBtn_pos_constraint_H)
        self.addConstraint(gridBtn_pos_constraint_V)
        self.mapBtn.addConstraints(mapBtn_constraint_H)
        self.mapBtn.addConstraints(mapBtn_constraint_V)
        self.addConstraints(mapBtn_pos_constraint_H)
        self.addConstraint(mapBtn_pos_constraint_V)
        self.upImgView.addConstraints(upImage_constraint_H)
        self.upImgView.addConstraints(upImage_constraint_V)
        self.addConstraint(upImage_pos_constraint_H)
        self.addConstraints(text_pos_constraint_H)
        self.addConstraints(upImage_text_pos_constraint_V)
        
    }
}
