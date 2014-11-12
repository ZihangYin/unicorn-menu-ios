//
//  CollectionViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/8/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let textLabel: UILabel!
//    let imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: frame.size.width, height: frame.size.height*2/3))
//        imageView.contentMode = UIViewContentMode.ScaleAspectFit
//        self.contentView.addSubview(imageView)
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        textLabel = UILabel(frame: textFrame)
//        textLabel.numberOfLines = 0
//        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        textLabel.textAlignment = .Center
        self.contentView.addSubview(textLabel)
//
//        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[textLabel]-|", options: nil, metrics: nil, views: ["textLabel": self.textLabel, "imageView": self.imageView]))

    }
    
    /*
    Computes the size the cell will need to to fit within targetSize.
    
    targetSize should be used to pass in a width.
    the returned size will have the same width, and the height which is
    calculated by Auto Layout so that the contents of the cell (i.e., text in the label)
    can fit within that width.
    */
//    func preferredLayoutSizeFittingSize(targetSize: CGSize) -> CGSize {
//        
//        // save original frame and preferredMaxLayoutWidth
//        let originalFrame = self.frame
//        let originalPreferredMaxLayoutWidth = self.textLabel.preferredMaxLayoutWidth
//        println("originalPreferredMaxLayoutWidth: \(originalPreferredMaxLayoutWidth)")
//
//        // assert: targetSize.width has the required width of the cell
//        
//        // step1: set the cell.frame to use that width
//        var frame = self.frame
//        frame.size = targetSize
//        self.frame = frame
//        
//        // step2: layout the cell
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//        self.textLabel.preferredMaxLayoutWidth = self.textLabel.bounds.size.width
//        println("preferredMaxLayoutWidth: \(self.textLabel.bounds.size.width)")
//
//        
//        // assert: the cell.label.bounds.size.width has now been set to the width required by the cell.bounds.size.width
//        
//        // step3: compute how tall the cell needs to be
//        
//        // this causes the cell to compute the height it needs, which it does by asking the
//        // label what height it needs to wrap within its current bounds (which we just set).
//        // (note that the label is getting its wrapping width from its bounds, not preferredMaxLayoutWidth)
//        let computedSize = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//        // assert: computedSize has the needed height for the cell
//        println("\(targetSize.width) + \(computedSize.height)")
//        // Apple: "Only consider the height for cells, because the contentView isn't anchored correctly sometimes."
//        let newSize = CGSize(width: targetSize.width, height: computedSize.height)
//        
//        // restore old frame
//        self.frame = originalFrame
//        self.textLabel.preferredMaxLayoutWidth = originalPreferredMaxLayoutWidth
//        return newSize
//    }
}
