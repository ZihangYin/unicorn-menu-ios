//
//  CollectionViewHorizontalFlowLayout.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/18/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class CollectionViewHorizontalFlowLayout: UICollectionViewFlowLayout {
    
    var page: CGFloat = 0;
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        return CGPointMake(self.page * screenWidth, 0);
    }
}
