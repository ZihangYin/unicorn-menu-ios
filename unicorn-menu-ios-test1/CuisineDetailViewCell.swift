//
//  RestaurantDetailViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/25/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class CuisineDetailViewCell: UICollectionViewCell {

    var cuisineDetailView: CuisineDetailView!
    var pulledAction : ((offset : CGPoint) -> Void)?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        cuisineDetailView = CuisineDetailView(frame: self.contentView.frame)
        self.addSubview(cuisineDetailView)
    }
    
}
