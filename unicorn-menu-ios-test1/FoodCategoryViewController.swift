//
//  FilterDetailViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/4/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit
import QuartzCore

class FilterCell {
    
    var itemName = ""
    var checked = false
    
    init(name: String){
        self.itemName = name
    }
    
    init(name: String, checked: Bool){
        self.itemName = name
        self.checked = checked
    }
}


class FilterViewCell: UITableViewCell {
    
    var label = UILabel()
    var bottomLine = UIView()
    var checkView = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = .None
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textAlignment = .Left
        label.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.contentView.addSubview(label)
        
        bottomLine.setTranslatesAutoresizingMaskIntoConstraints(false)
        bottomLine.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        self.contentView.addSubview(bottomLine)
        
        checkView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(checkView)
        
        let viewsDictionary = ["label": self.label, "bottomLine": self.bottomLine, "checkView": self.checkView]
        self.bottomLine.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomLine(0.5)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.checkView.addConstraint(NSLayoutConstraint(item: self.checkView, attribute: .Width, relatedBy: .Equal, toItem: self.checkView, attribute: .Height, multiplier: 1, constant: 0.5))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[checkView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[checkView]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[label]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.label, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1, constant: 0.5))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bottomLine]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.bottomLine, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1, constant: 0))
    }
}


class FoodCategoryViewController: UITableViewController, UITableViewDelegate {
    
    let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Food Categories"
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.frame = CGRectMake(0.0, 0.0, 55, 55);
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        negativeSpacer.width = -25
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftBarButton]
        
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.registerClass(FilterViewCell.self, forCellReuseIdentifier: "FoodCategoryTableCell")
        self.tableView.separatorStyle = .None
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var edgePanRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges = .Left;
        self.tableView.addGestureRecognizer(edgePanRecognizer)
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = percentDrivenInteractiveTransition
    }
    
    func handleEdgePanRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        
        var progress: CGFloat = recognizer.translationInView(self.view).x / self.view.bounds.size.width
        progress = min(1.0, max(0.0, progress))

        switch (recognizer.state) {
        case .Began:
            self.navigationController!.popViewControllerAnimated(true)
        case .Changed:
            self.percentDrivenInteractiveTransition.updateInteractiveTransition(progress);
        default:
            if recognizer.velocityInView(self.view).x >= 0 {
                self.percentDrivenInteractiveTransition.finishInteractiveTransition()
                self.view.removeGestureRecognizer(recognizer)
            } else {
                self.percentDrivenInteractiveTransition.cancelInteractiveTransition()
            }
            break;
        }
    }
    
    func backButtonPressed() {
        if !(self.tableView.delegate as FilterTableViewDelegate).ifAnyItemisChecked(self.tableView) {
            self.tableView.delegate!.tableView!(self.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        }
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = nil
        self.navigationController!.popViewControllerAnimated(true)
    }
}
