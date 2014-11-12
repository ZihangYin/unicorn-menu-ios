//
//  CollectionReusableView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/9/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    
    let searchIcon: UIButton!
    let searchText: UITextField!
    let rightBarIcon: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        searchIcon = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        searchIcon.frame = CGRectMake(10, 5, 20, 20);
        searchIcon.tintColor = UIColor.blackColor()
        searchIcon.setImage(UIImage(named: "Search-icon.png"), forState: UIControlState.Normal)
        self.addSubview(searchIcon)
        
        searchText = UITextField(frame: CGRectMake(45, 5, 200, 20))
        searchText.font = UIFont(name: "ProximaNova-Light", size: 12)
        searchText.placeholder = "Search"
        self.addSubview(searchText)
        
        rightBarIcon = UIButton.buttonWithType(UIButtonType.System) as UIButton
        rightBarIcon.frame = CGRectMake(frame.size.width - 85, 5, 75, 20);
        rightBarIcon.tintColor = UIColor.lightGrayColor()
        rightBarIcon.setTitle("Downtown LA", forState: UIControlState.Normal)
        rightBarIcon.titleLabel!.font = UIFont(name: "ProximaNova-Light", size: 12)
        self.addSubview(rightBarIcon)
    }
}
