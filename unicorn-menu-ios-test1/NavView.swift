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

        gridBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        gridBtn.frame = CGRectMake(5, 0, 45, 45)
        gridBtn.setImage(UIImage(named: "scan.png"), forState: UIControlState.Normal)
        self.addSubview(gridBtn)

        upImgView = UIImageView(frame: CGRectMake(self.frame.size.width / 2 - 10 , 0, 20, 20));
        var upImg = UIImage(named: "up.png")
        upImgView.image = upImg;
        self.addSubview(upImgView);
        
        let textFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        textLabel = UILabel(frame: textFrame)
        textLabel.font = UIFont(name: "ProximaNova-Light", size: 20)
        textLabel.textColor = UIColor.whiteColor()
        textLabel.textAlignment = .Center
        textLabel.text = "DISCOVER"
        self.addSubview(textLabel)
        
        mapBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        mapBtn.frame = CGRectMake(self.frame.width - 50, 0, 45, 45)
        mapBtn.setImage(UIImage(named: "map.png"), forState: UIControlState.Normal)
        self.addSubview(mapBtn)
    }
}
