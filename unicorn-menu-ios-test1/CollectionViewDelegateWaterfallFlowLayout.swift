//
//  ColumeBasedCollectionViewDelegate.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/11/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@objc protocol CollectionViewDelegateWaterfallFlowLayout: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, heightForHeaderInSection section: Int) -> Float
    
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, heightForFooterInSection section: Int) -> Float
    
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSection section: Int) -> UIEdgeInsets
    
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, insetForHeaderInSection section: Int) -> UIEdgeInsets
    
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, insetForFooterInSection section: Int) -> UIEdgeInsets
    
    optional func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSection section: Int) -> Float
}