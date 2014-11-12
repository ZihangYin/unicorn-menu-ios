//
//  NavView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/9/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class NavView: UIView {
    
    let gridBtn: UIButton!
    let menuBtn: UIButton!
    let menuBtnSub: UIButton!
    let mapBtn: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gridBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        gridBtn.frame = CGRectMake(0, 0, 40, 40)
        gridBtn.tintColor = UIColor.blackColor()
        gridBtn.setImage(UIImage(named: "scan@3x.png"), forState: UIControlState.Normal)
        self.addSubview(gridBtn)
        
        menuBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menuBtn.frame = CGRectMake(frame.size.width/4, 5, frame.size.width/2, 20)
        menuBtn.tintColor = UIColor.blackColor()
        menuBtn.setTitle("Asian Food", forState: UIControlState.Normal)
        menuBtn.titleLabel!.font = UIFont(name: "ProximaNova-Light", size: 11)
        self.addSubview(menuBtn)
        
        menuBtnSub = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menuBtnSub.frame = CGRectMake(frame.size.width/4, 20, frame.size.width/2, 20)
        menuBtnSub.tintColor = UIColor.blackColor()
        menuBtnSub.setTitle("Dinner", forState: UIControlState.Normal)
        menuBtnSub.titleLabel!.font = UIFont(name: "ProximaNova-Light", size: 11)
        self.addSubview(menuBtnSub)
        
        mapBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        mapBtn.frame = CGRectMake(frame.size.width - 40, 0, 40, 40)
        mapBtn.tintColor = UIColor.blackColor()
        mapBtn.setImage(UIImage(named: "map2.png"), forState: UIControlState.Normal)
        self.addSubview(mapBtn)
    }
}
