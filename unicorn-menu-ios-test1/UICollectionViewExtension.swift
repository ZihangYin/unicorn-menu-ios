//
//  Extension.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import Foundation
import UIKit

var kIndexPathPointer = "kIndexPathPointer"

extension UICollectionView {

    func setToIndexPath(indexPath : NSIndexPath) {
        objc_setAssociatedObject(self, &kIndexPathPointer, indexPath, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
    
    func toIndexPath() -> NSIndexPath {
        let index = self.contentOffset.x / self.frame.size.width
        if index > 0 {
            return NSIndexPath(forRow: Int(index), inSection: 0)
        } else if let indexPath = objc_getAssociatedObject(self, &kIndexPathPointer) as? NSIndexPath {
            return indexPath
        } else {
            return NSIndexPath(forRow: 0, inSection: 0)
        }
    }
    
    func fromIndexPath () -> NSIndexPath{
        let index : Int = Int(self.contentOffset.x/self.frame.size.width)
        return NSIndexPath(forRow: index, inSection: 0)
    }
}