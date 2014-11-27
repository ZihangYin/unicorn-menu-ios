//
//  RestaurantDetailCollectionViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/25/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

let reuseIdentifier = "RestaurantDetailCell"

class CuisineDetailViewController: UIViewController {

    var index: Int!
    var cuisineDetailView: CuisineDetailView!
    
    required init(image: UIImage, cuisineName: String, cuisineDescription: String) {
        super.init()
        cuisineDetailView = CuisineDetailView(frame: self.view.frame, backgroundImage: image, blurredImage: nil, viewDistanceFromBottom: 50, foregroundView: self.customView(cuisineName, cuisineDescription: cuisineDescription))
        self.view.addSubview(cuisineDetailView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.frame = CGRectMake(0.0, 0.0, 40, 40)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        negativeSpacer.width = -10
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftBarButton]
    }
    
    override func viewWillLayoutSubviews() {
        self.cuisineDetailView.setTopLayoutGuideLength(self.topLayoutGuide.length)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonPressed() {
        self.navigationController!.popViewControllerAnimated(false)
    }
    
    private func customView(cuisineName: String, cuisineDescription: String) -> UIView {
        
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 60))
        
//        var cuisineNameLabel = UILabel(frame: CGRectMake(5, 5, self.view.frame.width - 10, 120))
        var cuisineNameLabel = UILabel()
        cuisineNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineNameLabel.text = cuisineName
        cuisineNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 40)
        cuisineNameLabel.textAlignment = .Left
        cuisineNameLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        cuisineNameLabel.numberOfLines = 10
        cuisineNameLabel.lineBreakMode = .ByWordWrapping
        cuisineNameLabel.textColor = UIColor.whiteColor()
        cuisineNameLabel.shadowColor = UIColor.blackColor()
        cuisineNameLabel.shadowOffset = CGSizeMake(1, 1)
        
//        var cuisineDescriptionBox = UIView(frame: CGRectMake(5, 60, self.view.frame.width - 10, 120))
        var cuisineDescriptionBox = UIView()
        cuisineDescriptionBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineDescriptionBox.layer.cornerRadius = 3;
        cuisineDescriptionBox.backgroundColor = UIColor(white: 0, alpha: 0.15)
        
//        var cuisineDescriptionLabel = UILabel(frame: CGRectMake(5, 60, self.view.frame.width - 10, 120))
        var cuisineDescriptionLabel = UILabel()
        cuisineDescriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineDescriptionLabel.text = cuisineDescription
        cuisineDescriptionLabel.font = UIFont(name: "ProximaNova-Regualr", size: 24)
        cuisineDescriptionLabel.textAlignment = .Left
        cuisineDescriptionLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        cuisineDescriptionLabel.numberOfLines = 20
        cuisineDescriptionLabel.lineBreakMode = .ByWordWrapping
        cuisineDescriptionLabel.textColor = UIColor.whiteColor()
        
        view.addSubview(cuisineNameLabel)
        view.addSubview(cuisineDescriptionLabel)
        view.addSubview(cuisineDescriptionBox)
        
        var viewsDictionary = ["cuisineName": cuisineNameLabel, "cuisineDescriptionBox": cuisineDescriptionBox, "cuisineDescription": cuisineDescriptionLabel]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[cuisineName]-15-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[cuisineDescriptionBox]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[cuisineDescription]-15-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        view.addConstraint(NSLayoutConstraint(item: cuisineDescriptionBox, attribute: .Top, relatedBy: .Equal, toItem: cuisineDescriptionLabel, attribute: .Top, multiplier: 1, constant: 0))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[cuisineName]-10-[cuisineDescriptionBox(>=150)]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        return view

    }
}
