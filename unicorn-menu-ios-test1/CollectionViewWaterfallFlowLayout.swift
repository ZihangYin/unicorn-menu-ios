//
//  CollectionViewFlowLayout.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/9/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

let CollectionViewWaterfallFlowLayoutElementKindSectionHeader = "CollectionViewWaterfallFlowLayoutElementKindSectionHeader"
let CollectionViewWaterfallFlowLayoutElementKindSectionFooter = "CollectionViewWaterfallFlowLayoutElementKindSectionFooter"

class CollectionViewWaterfallFlowLayout: UICollectionViewLayout {
   
    var columnCount: Int = 2 {
        didSet {
            invalidateIfNotEqual(oldValue, newValue: columnCount)
        }
    }
    var minimumColumnSpacing: Float = 7.0 {
        didSet {
            invalidateIfNotEqual(oldValue, newValue: minimumColumnSpacing)
        }
    }
    var minimumInteritemSpacing: Float = 7.0 {
        didSet {
            invalidateIfNotEqual(oldValue, newValue: minimumInteritemSpacing)
        }
    }
    var headerHeight: Float = 0.0 {
        didSet {
            invalidateIfNotEqual(oldValue, newValue: headerHeight)
        }
    }
    var footerHeight: Float = 0.0 {
        didSet {
            invalidateIfNotEqual(oldValue, newValue: footerHeight)
        }
    }
    var headerInset: UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            invalidateIfNotEqual(NSValue(UIEdgeInsets: oldValue), newValue: NSValue(UIEdgeInsets: headerInset))
        }
    }
    var footerInset: UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            invalidateIfNotEqual(NSValue(UIEdgeInsets: oldValue), newValue: NSValue(UIEdgeInsets: footerInset))
        }
    }
    var sectionInset: UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            invalidateIfNotEqual(NSValue(UIEdgeInsets: oldValue), newValue: NSValue(UIEdgeInsets: sectionInset))
        }
    }
    var columnWidth: Float {
        get {
            return _columnWidth
        }
    }
    
    private weak var delegate: CollectionViewDelegateWaterfallFlowLayout?  {
        get {
            return self.collectionView!.delegate as? CollectionViewDelegateWaterfallFlowLayout
        }
    }
    // How many items to be union into a single rectangle
    private let unionSize = 25;
    private var columnHeights = [Float]()
    private var _columnWidth: Float = 0.0
    private var sectionItemAttributes = [[UICollectionViewLayoutAttributes]]()
    private var allItemAttributes = [UICollectionViewLayoutAttributes]()
    private var headersAttribute = [Int: UICollectionViewLayoutAttributes]()
    private var footersAttribute = [Int: UICollectionViewLayoutAttributes]()
    private var unionRects = [CGRect]()
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let numberOfSections = self.collectionView!.numberOfSections()
        if numberOfSections == 0 {
            return;
        }
        
        assert(self.delegate!.conformsToProtocol(CollectionViewDelegateWaterfallFlowLayout), "UICollectionView's delegate should conform to CollectionViewDelegateWaterfallFlowLayout protocol")
        assert(self.columnCount > 0, "CollectionViewWaterfallFlowLayout's columnCount should be greater than 0")
        
        // Initialize variables
        self.headersAttribute.removeAll(keepCapacity: false)
        self.footersAttribute.removeAll(keepCapacity: false)
        self.allItemAttributes.removeAll(keepCapacity: false)
        self.sectionItemAttributes.removeAll(keepCapacity: false)
        self.unionRects.removeAll(keepCapacity: false)
        self.columnHeights.removeAll(keepCapacity: false)

        for index in 0 ..< self.columnCount {
            self.columnHeights.append(0)
        }
        
        // Create attributes
        var top: Float = 0
        var attributes: UICollectionViewLayoutAttributes
        
        for section in 0 ..< numberOfSections {
            /*
            * 1. Get section-specific metrics (minimumInteritemSpacing, sectionInset)
            */
            var minimumInteritemSpacing: Float
            if let height = self.delegate?.collectionView?(self.collectionView!, layout: self, minimumInteritemSpacingForSection: section) {
                minimumInteritemSpacing = height
            } else {
                minimumInteritemSpacing = self.minimumInteritemSpacing
            }
            
            var sectionInset: UIEdgeInsets
            if let inset = self.delegate?.collectionView?(self.collectionView!, layout: self, insetForSection: section) {
                sectionInset = inset
            } else {
                sectionInset = self.sectionInset
            }
            
            let width = Float(self.collectionView!.frame.size.width - sectionInset.left - sectionInset.right)
            _columnWidth = floorf((width - Float(self.columnCount - 1) * Float(self.minimumColumnSpacing)) / Float(self.columnCount))
            
            /*
            * 2. Section header
            */
            var headerHeight: Float
            if let height = self.delegate?.collectionView?(self.collectionView!, layout: self, heightForHeaderInSection: section) {
                headerHeight = height
            } else {
                headerHeight = self.headerHeight
            }
            
            var headerInset: UIEdgeInsets
            if let inset = self.delegate?.collectionView?(self.collectionView!, layout: self, insetForHeaderInSection: section) {
                headerInset = inset
            } else {
                headerInset = self.headerInset
            }
            top += Float(headerInset.top)

            if headerHeight > 0 {
                attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: CollectionViewWaterfallFlowLayoutElementKindSectionHeader, withIndexPath: NSIndexPath(forItem: 0, inSection: section))
                attributes.frame = CGRect(x: 0, y: CGFloat(top), width: self.collectionView!.frame.size.width - (headerInset.left + headerInset.right), height: CGFloat(headerHeight))

                self.headersAttribute[section] = attributes
                self.allItemAttributes.append(attributes)
                top = Float(CGRectGetMaxY(attributes.frame)) + Float(headerInset.bottom)
            }
            
            top += Float(sectionInset.top)
            for index in 0 ..< self.columnCount {
                self.columnHeights[index] = top
            }
            
            /*
            * 3. Section items
            */
            let itemCount = self.collectionView!.numberOfItemsInSection(section)
            var itemAttributes = [UICollectionViewLayoutAttributes]()
            
            // Item will be put into shortest column.
            for index in 0 ..< itemCount {
                let indexPath = NSIndexPath(forItem: index, inSection: section)
                let columnIndex = shortestColumnIndex()
                
                let xOffset = Float(sectionInset.left) + Float(_columnWidth + self.minimumColumnSpacing) * Float(columnIndex)
                let yOffset = self.columnHeights[columnIndex]
                let itemSize = self.delegate?.collectionView(self.collectionView!, layout: self, sizeForItemAtIndexPath: indexPath)
                var itemHeight: Float = 0.0
                if itemSize?.height > 0 && itemSize?.width > 0 {
                    itemHeight = Float(itemSize!.height) * _columnWidth / Float(itemSize!.width)
                }
                
                attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = CGRect(x: CGFloat(xOffset), y: CGFloat(yOffset), width: CGFloat(_columnWidth), height: CGFloat(itemHeight))
                itemAttributes.append(attributes)
                self.allItemAttributes.append(attributes)
                self.columnHeights[columnIndex] = Float(CGRectGetMaxY(attributes.frame)) + minimumInteritemSpacing
            }
            
            self.sectionItemAttributes.append(itemAttributes)
            
            /*
            * 4. Section footer
            */
            var footerHeight: Float
            var columnIndex = longestColumnIndex()
            top = self.columnHeights[columnIndex] - minimumInteritemSpacing + Float(sectionInset.bottom)
            
            if let height = self.delegate?.collectionView?(self.collectionView!, layout: self, heightForFooterInSection: section) {
                footerHeight = height
            } else {
                footerHeight = self.footerHeight
            }
            
            var footerInset: UIEdgeInsets
            if let inset = delegate?.collectionView?(self.collectionView!, layout: self, insetForFooterInSection: section) {
                footerInset = inset
            } else {
                footerInset = self.footerInset
            }
            top += Float(footerInset.top)
            
            if footerHeight > 0 {
                attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: CollectionViewWaterfallFlowLayoutElementKindSectionFooter, withIndexPath: NSIndexPath(forItem: 0, inSection: section))
                attributes.frame = CGRect(x: footerInset.left, y: CGFloat(top), width: self.collectionView!.frame.size.width - (footerInset.left + footerInset.right), height: CGFloat(footerHeight))
                
                self.footersAttribute[section] = attributes
                self.allItemAttributes.append(attributes)
                
                top = Float(CGRectGetMaxY(attributes.frame)) + Float(footerInset.bottom)
            }
            
            for index in 0 ..< self.columnCount {
                self.columnHeights[index] = top
            }
        }
        
        // Build union rects
        var index = 0
        let itemCounts = self.allItemAttributes.count
        
        while index < itemCounts {
            let rect1 = self.allItemAttributes[index].frame
            index = min(index + unionSize, itemCounts) - 1
            let rect2 = self.allItemAttributes[index].frame
            self.unionRects.append(CGRectUnion(rect1, rect2))
            ++index
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        let numberOfSections = self.collectionView!.numberOfSections()
        if numberOfSections == 0 {
            return CGSizeZero
        }
        
        var contentSize = self.collectionView!.bounds.size
        contentSize.height = CGFloat(columnHeights[0])
        
        return contentSize
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        invalidateLayoutWithContext(invalidationContextForBoundsChange(newBounds))
        let oldBounds = self.collectionView!.bounds
        if CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds) {
            return true
        }
        
        return false
    }
    
//    override func invalidationContextForBoundsChange(newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
//        var sectionIndexPaths = [NSIndexPath]()
//        for index in 0 ..< self.collectionView!.numberOfSections() {
//            sectionIndexPaths.append(NSIndexPath(forItem: 0, inSection: index))
//        }
//        
//        var context = super.invalidationContextForBoundsChange(newBounds)
//        context.invalidateSupplementaryElementsOfKind(CollectionViewWaterfallFlowLayoutElementKindSectionHeader, atIndexPaths: sectionIndexPaths)
//        
//        return context
//    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        if indexPath.section >= self.sectionItemAttributes.count {
            return nil
        }
        if indexPath.item >= self.sectionItemAttributes[indexPath.section].count {
            return nil
        }
        
        return self.sectionItemAttributes[indexPath.section][indexPath.item]
    }
    
//    override func layoutAttributesForSupplementaryViewOfKind(kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
//        var attribute: UICollectionViewLayoutAttributes?
//        
//        if kind == CollectionViewWaterfallFlowLayoutElementKindSectionHeader {
//            var originalAttribute = self.headersAttribute[indexPath.section]
//            attribute = originalAttribute!.copy() as? UICollectionViewLayoutAttributes
//            let contentOffset = self.collectionView!.contentOffset
//            var headerFrame: CGRect = attribute!.frame
//            headerFrame.origin.y = max(contentOffset.y, headerFrame.origin.y)
//            
//            if (indexPath.section + 1 < self.collectionView!.numberOfSections()) {
//                var nextHeaderFrame = self.headersAttribute[indexPath.section + 1]!.frame
//                headerFrame.origin.y = min(nextHeaderFrame.origin.y - headerFrame.size.height, headerFrame.origin.y)
//            }
//            
//            attribute!.zIndex = 1024
//            attribute!.frame = headerFrame
//            
//        } else if kind == CollectionViewWaterfallFlowLayoutElementKindSectionFooter {
//            attribute = self.footersAttribute[indexPath.section]
//        }
//        
//        return attribute
//    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var begin: Int = 0
        var end: Int = self.unionRects.count
        var attrs = [UICollectionViewLayoutAttributes]()
        
        for i in 0 ..< end {
            if CGRectIntersectsRect(rect, self.unionRects[i]) {
                begin = i * unionSize
                break
            }
        }
        
        for i in reverse(0 ..< self.unionRects.count) {
            if CGRectIntersectsRect(rect, self.unionRects[i]) {
                end = min((i+1) * unionSize, allItemAttributes.count)
                break
            }
        }
        
        for var i = begin; i < end; i++ {
            let attribute = self.allItemAttributes[i]
            if CGRectIntersectsRect(rect, attribute.frame) {
                // nil when representedElementCategory is UICollectionElementCategoryCell
//                if let representedElementKind = attribute.representedElementKind {
//                    if (representedElementKind == CollectionViewWaterfallFlowLayoutElementKindSectionHeader) {
//                        attrs.append(layoutAttributesForSupplementaryViewOfKind(representedElementKind, atIndexPath: attribute.indexPath))
//                    } else{
//                        attrs.append(attribute)
//                    }
//                } else {
                    attrs.append(attribute)
 //               }
            }
        }
        
        return Array(attrs)
    }
    
    private func shortestColumnIndex() -> Int {
        var index: Int = 0
        var shortestHeight = MAXFLOAT
        for (idx, height) in enumerate(self.columnHeights) {
            if height < shortestHeight {
                shortestHeight = height
                index = idx
            }
        }
        
        return index
    }
    
    private func longestColumnIndex() -> Int {
        var index: Int = 0
        var longestHeight:Float = 0
        
        for (idx, height) in enumerate(self.columnHeights) {
            if height > longestHeight {
                longestHeight = height
                index = idx
            }
        }
        
        return index
    }
    
    private func invalidateIfNotEqual(oldValue: AnyObject, newValue: AnyObject) {
        if !oldValue.isEqual(newValue) {
            invalidateLayout()
        }
    }
}