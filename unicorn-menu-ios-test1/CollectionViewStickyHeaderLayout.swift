//
//  CollectionViewStickyHeaderLayout.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/3/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class CollectionViewStickyHeaderLayoutAttributes: UICollectionViewLayoutAttributes {
    // 0 = minimized, 1 = fully expanded, > 1 = stretched
    var progressiveness: CGFloat = 1.0
}

let CollectionViewStickyHeaderLayoutElementKindSectionHeader = "CollectionViewStickyHeaderLayoutElementKindSectionHeader"

class CollectionViewStickyHeaderLayout: UICollectionViewFlowLayout {
    var parallaxHeaderReferenceSize: CGSize = CGSize()
    var parallaxHeaderMinimumReferenceSize: CGSize =  CGSize()
    var parallaxHeaderAlwaysOnTop = true

    override func initialLayoutAttributesForAppearingSupplementaryElementOfKind(elementKind: String, atIndexPath elementIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        var attributes: UICollectionViewLayoutAttributes? = nil
        attributes = super.initialLayoutAttributesForAppearingSupplementaryElementOfKind(elementKind, atIndexPath: elementIndexPath)
        if attributes != nil {
            var frame = attributes!.frame;
            frame.origin.y += self.parallaxHeaderReferenceSize.height
            attributes!.frame = frame
        }
        return attributes
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        
        var attributes: UICollectionViewLayoutAttributes? = super.layoutAttributesForSupplementaryViewOfKind(kind, atIndexPath:indexPath)
        if (attributes == nil && kind == CollectionViewStickyHeaderLayoutElementKindSectionHeader) {
            attributes = CollectionViewStickyHeaderLayoutAttributes(forSupplementaryViewOfKind: kind, withIndexPath: indexPath)
        }
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        var frame = attributes.frame;
        frame.origin.y += self.parallaxHeaderReferenceSize.height;
        attributes.frame = frame;
        return attributes;
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        var size = super.collectionViewContentSize()
        size.height += self.parallaxHeaderReferenceSize.height
        return size
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    func updateHeaderAttributes(attributes: UICollectionViewLayoutAttributes, lastCellAttributes: UICollectionViewLayoutAttributes) -> Void {
        let currentBounds = self.collectionView!.bounds
        attributes.zIndex = 2048
        attributes.hidden = false
        
        var origin = attributes.frame.origin
        var sectionMaxY = CGRectGetMaxY(lastCellAttributes.frame) - attributes.frame.size.height
        var y = CGRectGetMaxY(currentBounds) - currentBounds.size.height + self.collectionView!.contentInset.top
        
        if (self.parallaxHeaderAlwaysOnTop) {
            y += self.parallaxHeaderMinimumReferenceSize.height
        }
        
        var maxY = min(max(y, attributes.frame.origin.y), sectionMaxY)
        origin.y = maxY
        attributes.frame = CGRectMake(origin.x, origin.y, attributes.frame.size.width, attributes.frame.size.height)
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
        // The rect should compensate the header size
        var adjustedRect: CGRect = rect
        adjustedRect.origin.y -= self.parallaxHeaderReferenceSize.height
        
        var allItems = super.layoutAttributesForElementsInRect(adjustedRect) as Array<UICollectionViewLayoutAttributes>
        var lastCells = Dictionary<Int, UICollectionViewLayoutAttributes>()
        var visibleParallexHeader : Bool?
        
        for attributes in allItems {
            var frame = attributes.frame
            frame.origin.y += self.parallaxHeaderReferenceSize.height
            attributes.frame = frame
            
            var indexPath: NSIndexPath = attributes.indexPath
            if let representedElementKind = attributes.representedElementKind {
                if representedElementKind == UICollectionElementKindSectionHeader {
                    // Not implemeneted
                } else if representedElementKind == UICollectionElementKindSectionFooter {
                    // Not implemeneted
                } else {
                    var currentAttribute = lastCells[indexPath.section]
                    // Get the bottom most cell of that section
                    if (currentAttribute == nil || indexPath.item > currentAttribute!.indexPath.item) {
                        lastCells[indexPath.section] = attributes
                    }
                    if (indexPath.item == 0 && indexPath.section == 0) {
                        visibleParallexHeader = true
                    }
                }
                attributes.zIndex = 1
            }
        }
        
        // when the visible rect is at top of the screen, make sure we see
        // the parallex header
        if (CGRectGetMinY(rect) <= 0) {
            visibleParallexHeader = true
        }
        
        if (self.parallaxHeaderAlwaysOnTop == true) {
            visibleParallexHeader = true
        }
        
        var numberOfSections : Int = self.collectionView!.dataSource!.respondsToSelector(Selector("numberOfSectionsInCollectionView:")) ? self.collectionView!.dataSource!.numberOfSectionsInCollectionView!(self.collectionView!) : 1
        
        // Create the attributes for the Parallex header
        if (visibleParallexHeader == true && !CGSizeEqualToSize(CGSizeZero, self.parallaxHeaderReferenceSize) && numberOfSections > 0) {
            
            var indexPathTemp = NSIndexPath(forItem: 0, inSection: 0)
            var currentAttribute : CollectionViewStickyHeaderLayoutAttributes = CollectionViewStickyHeaderLayoutAttributes(forSupplementaryViewOfKind: CollectionViewStickyHeaderLayoutElementKindSectionHeader, withIndexPath: indexPathTemp)
            
            var frame : CGRect = currentAttribute.frame
            frame.size.width = self.parallaxHeaderReferenceSize.width
            frame.size.height = self.parallaxHeaderReferenceSize.height
            
            var bounds = self.collectionView!.bounds
            var maxY = CGRectGetMaxY(frame)
            
            // make sure the frame won't be negative values
            var y = min(maxY - self.parallaxHeaderMinimumReferenceSize.height, bounds.origin.y + self.collectionView!.contentInset.top)
            var height = max(0, -y + maxY)
            
            var maxHeight = self.parallaxHeaderReferenceSize.height
            var minHeight = self.parallaxHeaderMinimumReferenceSize.height
            var progressiveness = (height - minHeight)/(maxHeight - minHeight)
            currentAttribute.progressiveness = progressiveness
            
            // if zIndex < 0 would prevents tap from recognized right under navigation bar
            currentAttribute.zIndex = 0
            
            // When parallaxHeaderAlwaysOnTop is enabled, we will check when we should update the y position
            if (self.parallaxHeaderAlwaysOnTop && height <= self.parallaxHeaderMinimumReferenceSize.height) {
                var insetTop = self.collectionView!.contentInset.top
                // Always stick to top but under the nav bar
                y = self.collectionView!.contentOffset.y + insetTop
                currentAttribute.zIndex = 2000
            }
            
            currentAttribute.frame = CGRectMake(frame.origin.x, y, frame.size.width, height)
            
            allItems.append(currentAttribute)
        }
        return allItems
    }
}
