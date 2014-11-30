//
//  DiscoverDetailViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/17/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class DiscoverDetailTableViewCell : UITableViewCell {
    
    var cuisineImage = UIImageView()
    var cuisineNameLabel = UILabel()
    private var cuisineLikesLogo = UIImageView(image: UIImage(named: "liked.png"))
    var cuisineLikesLabel = UILabel()
    var cuisinePriceLabel = UILabel()
    private var logoView = UIImageView(image: UIImage(named: "logo.png"))
    var restaurantName = UILabel()
    private var bottomBorderForCuisineName = UIView()
    var restaurantView = UIView()
//    private var bottomBorderForRestaurantName = UIView()
    
    private var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                cuisineImage.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                cuisineImage.addConstraint(aspectConstraint!)
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.darkGrayColor()
        self.selectionStyle = .None
        
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.cuisineImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineImage.clipsToBounds = true
        
        self.cuisineNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 24)
        self.cuisineNameLabel.textAlignment = .Left
        self.cuisineNameLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        self.cuisineNameLabel.numberOfLines = 10
        self.cuisineNameLabel.lineBreakMode = .ByWordWrapping
        self.cuisineNameLabel.textColor = UIColor.whiteColor()
        
        self.cuisineLikesLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLogo.clipsToBounds = true
        
        self.cuisineLikesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisineLikesLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
        self.cuisineLikesLabel.textAlignment = .Center
        self.cuisineLikesLabel.textColor = UIColor.whiteColor()
        
        self.cuisinePriceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.cuisinePriceLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
        self.cuisinePriceLabel.textAlignment = .Left
        self.cuisinePriceLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        self.cuisinePriceLabel.numberOfLines = 20
        self.cuisinePriceLabel.lineBreakMode = .ByWordWrapping
        self.cuisinePriceLabel.textColor = UIColor.whiteColor()
        
        self.bottomBorderForCuisineName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bottomBorderForCuisineName.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        self.logoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoView.clipsToBounds = true
        
        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.numberOfLines = 10
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 12)
        self.restaurantName.textAlignment = .Center
        self.restaurantName.lineBreakMode = .ByWordWrapping
        self.restaurantName.textColor = UIColor.whiteColor()
        
//        self.bottomBorderForRestaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.bottomBorderForRestaurantName.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        
        self.restaurantView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantView.addSubview(logoView)
        self.restaurantView.addSubview(restaurantName)
//        self.restaurantView.addSubview(bottomBorderForRestaurantName)
        
        self.contentView.addSubview(cuisineImage)
        self.contentView.addSubview(cuisineNameLabel)
        self.contentView.addSubview(cuisineLikesLogo)
        self.contentView.addSubview(cuisineLikesLabel)
        self.contentView.addSubview(cuisinePriceLabel)
        self.contentView.addSubview(bottomBorderForCuisineName)
        self.contentView.addSubview(restaurantView)
        
        autoLayoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
 
    }
    
    func setCuisineImage(image: UIImage) {
        let aspect = image.size.width / image.size.height
        aspectConstraint = NSLayoutConstraint(item: cuisineImage, attribute: .Width, relatedBy: .Equal, toItem: cuisineImage, attribute: .Height, multiplier: aspect, constant: 0.0)
        cuisineImage.image = image
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["cuisineImage": self.cuisineImage, "cuisineNameLabel": self.cuisineNameLabel, "bottomBorderForCuisineName": self.bottomBorderForCuisineName, "cuisineLikesLogo": self.cuisineLikesLogo, "cuisineLikesLabel": self.cuisineLikesLabel,
            "cuisinePriceLabel": self.cuisinePriceLabel, "restaurantView": self.restaurantView, "logoView": self.logoView, "restaurantName": self.restaurantName]
        
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.logoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[logoView(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cuisineLikesLogo(30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[cuisineLikesLogo(30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.bottomBorderForCuisineName.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomBorderForCuisineName(1)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
//        self.bottomBorderForRestaurantName.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomBorderForRestaurantName(1)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.restaurantView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[logoView]-10-[restaurantName]-0-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.logoView, attribute: .CenterX, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterX, multiplier: 1, constant: 0))
        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.restaurantName, attribute: .CenterX, relatedBy: .Equal, toItem: self.restaurantView, attribute: .CenterX, multiplier: 1, constant: 0))
//        self.restaurantView.addConstraint(NSLayoutConstraint(item: self.bottomBorderForRestaurantName, attribute: .Width, relatedBy: .Equal, toItem: self.restaurantView, attribute: .Width, multiplier: 1, constant: 0))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cuisineImage, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.bottomBorderForCuisineName, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cuisineNameLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.restaurantView, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cuisinePriceLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1, constant: 5))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLogo, attribute: .Right, relatedBy: .Equal, toItem: self.cuisineLikesLabel, attribute: .Left, multiplier: 1, constant: 2.5))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cuisineLikesLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.cuisineLikesLogo, attribute: .CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cuisineImage]-10-[cuisineNameLabel]-10-[cuisineLikesLabel]-10-[cuisinePriceLabel]-10-[bottomBorderForCuisineName]-10-[restaurantView]-10-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }

}

class DiscoverDetailCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var cuisineImage: UIImage?
    var cuisineName: String?
    var restaurantName: String?
    var cuisineLikes: String?
    var pulledAction: ((offset : CGPoint) -> Void)?
    var tappedAction: (() -> Void)?
    let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.backgroundColor = UIColor.darkGrayColor()
        self.tableView.registerClass(DiscoverDetailTableViewCell.self, forCellReuseIdentifier: "DiscoverDetailTableCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 480
        
        self.contentView.addSubview(tableView)
        self.autoLayoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.reloadData()
    }
    
    // pragma mark - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let discoverDetailTableCell = tableView.dequeueReusableCellWithIdentifier("DiscoverDetailTableCell") as DiscoverDetailTableViewCell!
        discoverDetailTableCell.setCuisineImage(cuisineImage!)
        discoverDetailTableCell.cuisineNameLabel.text = "\(cuisineName!)"
        discoverDetailTableCell.cuisinePriceLabel.text = "$ " + String(arc4random()%20 + 15)
        discoverDetailTableCell.restaurantName.text = restaurantName!
        discoverDetailTableCell.cuisineLikesLabel.text = cuisineLikes!
        discoverDetailTableCell.setNeedsLayout()
        
        let tapRestaurantLogo = UITapGestureRecognizer.init(target: self, action: "handleTapRestaurant:")
        discoverDetailTableCell.restaurantView.addGestureRecognizer(tapRestaurantLogo)
        return discoverDetailTableCell
    }
    
//    // pragma mark - UITableViewDelegate
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var cellHeight = CGFloat(280.0)
//        if indexPath.row == 0 {
//            let screenWidth = UIScreen.mainScreen().bounds.size.width
//            cellHeight = self.image!.size.height *  screenWidth / self.image!.size.width
//        }
//        return cellHeight
//        return 360
//    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -80 {
            pulledAction?(offset: scrollView.contentOffset)
        }
    }
    
    func handleTapRestaurant(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }
        tappedAction?()
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["tableView": self.tableView]
        let tableView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let tableView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.addConstraints(tableView_constraint_H)
        self.addConstraints(tableView_constraint_V)
    }
}
