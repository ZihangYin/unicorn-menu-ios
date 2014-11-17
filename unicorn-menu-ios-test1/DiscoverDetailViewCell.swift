//
//  DiscoverDetailViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverDetailTableViewCell : UITableViewCell{
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRectZero
        if (imageView.image != nil) {
            let screenWidth = UIScreen.mainScreen().bounds.size.width
            let imageHeight = imageView.image!.size.height * screenWidth / imageView.image!.size.width
            imageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: imageHeight)
        }
    }
}

class DiscoverDetailCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var image: UIImage?
    var tappedAction : (() -> Void)?
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
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.contentView.addSubview(tableView)
        self.autoLayoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tableView.reloadData()
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["tableView": self.tableView]
        let tableView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let tableView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)

        self.addConstraints(tableView_constraint_H)
        self.addConstraints(tableView_constraint_V)
    }
    
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
        
        discoverDetailTableCell.setNeedsLayout()
        return discoverDetailTableCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var cellHeight = CGFloat(44.0)
        if indexPath.row == 0 {
            let screenWidth = UIScreen.mainScreen().bounds.size.width
            let imageHeight = self.image!.size.height *  screenWidth / self.image!.size.width
            cellHeight = imageHeight
        }
        return cellHeight
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        tappedAction?()
    }
    
    func scrollViewWillBeginDecelerating(scrollView : UIScrollView){
        if scrollView.contentOffset.y < UIApplication.sharedApplication().statusBarFrame.size.height {
            pulledAction?(offset: scrollView.contentOffset)
        }
    }
}
