//
//  CollectionViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/8/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 7.0
        self.backgroundColor =  UIColor.whiteColor()
        
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.frame = self.bounds
        self.imageView.layer.cornerRadius = 7.0
        self.imageView.clipsToBounds = true
    }
}
