//
//  DiscoverDetailViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverDetailTableViewCell : UITableViewCell {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
        self.imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.layoutMargins = UIEdgeInsetsZero
        self.selectionStyle = .None;
        
//        autoLayoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectZero
        if (imageView.image != nil) {
            let imageHeight = imageView.image!.size.height*UIScreen.mainScreen().bounds.size.width/imageView.image!.size.width
            imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, imageHeight)
        }
    }
    
//    private func autoLayoutSubviews() {
//        var viewsDictionary = ["imageView": self.imageView, "screenWidth": UIScreen.mainScreen().bounds.size.width]
//        let imageView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
//        let imageView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
//        
//        self.addConstraints(imageView_constraint_H)
//        self.addConstraints(imageView_constraint_V)
//    }
}

class DiscoverDetailCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var image: UIImage?
    var pulledAction : ((offset : CGPoint) -> Void)?
    let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.registerClass(DiscoverDetailTableViewCell.self, forCellReuseIdentifier: "DiscoverDetailTableCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.contentView.addSubview(tableView)
        self.autoLayoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.reloadData()
    }
    
    // pragma mark - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let discoverDetailTableCell = tableView.dequeueReusableCellWithIdentifier("DiscoverDetailTableCell") as DiscoverDetailTableViewCell!
        discoverDetailTableCell.imageView.image = nil
        discoverDetailTableCell.textLabel.text = nil
        
        if indexPath.row == 0 {
            discoverDetailTableCell.imageView.image = image!
        } else if indexPath.row == 1 {
            discoverDetailTableCell.textLabel.text = "Name"
        } else {
            discoverDetailTableCell.textLabel.text = "Description"
        }
        return discoverDetailTableCell
    }
    
    // pragma mark - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cellHeight = CGFloat(44.0)
        if indexPath.row == 0 {
            let screenWidth = UIScreen.mainScreen().bounds.size.width
            cellHeight = self.image!.size.height *  screenWidth / self.image!.size.width
        }
        return cellHeight
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < UIApplication.sharedApplication().statusBarFrame.size.height {
            pulledAction?(offset: scrollView.contentOffset)
        }
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["tableView": self.tableView]
        let tableView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let tableView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.addConstraints(tableView_constraint_H)
        self.addConstraints(tableView_constraint_V)
    }
}
