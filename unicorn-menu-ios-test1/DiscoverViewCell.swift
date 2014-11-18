//
//  CollectionViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/8/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@objc protocol DiscoverTansitionViewCellProtocol{
    func snapShotForDiscoverTransition() -> UIView!
}

class DiscoverViewCell: UICollectionViewCell, DiscoverTansitionViewCellProtocol {
    
    var imageView = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 7.0
        self.backgroundColor =  UIColor.whiteColor()
        
        self.imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.imageView.layer.cornerRadius = 7.0
        self.imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        autoLayoutSubviews()
    }
    
    // pragma mark - DiscoverTansitionViewCellProtocol
    func snapShotForDiscoverTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.imageView.image)
        snapShotView.frame = self.imageView.bounds
        return snapShotView
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["imageView": self.imageView]
        let imageView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let imageView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.addConstraints(imageView_constraint_H)
        self.addConstraints(imageView_constraint_V)
    }
}
