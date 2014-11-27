//
//  MenuViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/22/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class MenuViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var text = UILabel()
    
    var imageOffset: CGPoint = CGPointZero {
        didSet {
            let frame = self.imageView.bounds;
            let offsetFrame = CGRectOffset(frame, imageOffset.x, imageOffset.y);
            self.imageView.frame = offsetFrame;
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.clipsToBounds = true;

        // Add image subviewse
        self.imageView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 180)
        self.imageView.userInteractionEnabled = true
        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.clipsToBounds = false
        
        self.text.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
        self.text.font = UIFont(name: "ProximaNova-Bold", size: 24)
        self.text.textAlignment = .Center
        self.text.textColor = UIColor.whiteColor()
        self.text.shadowColor = UIColor.blackColor()
        self.text.shadowOffset = CGSizeMake(0, 1.0)

        contentView.addSubview(self.imageView)
        contentView.addSubview(self.text)
    }
}
