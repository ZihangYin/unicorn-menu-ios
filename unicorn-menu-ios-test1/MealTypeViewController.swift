//
//  MealTypeViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/4/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class MealTypeViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    let percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Meal Type"
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "left.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.frame = CGRectMake(0.0, 0.0, 55, 55);
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let negativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        negativeSpacer.width = -25
        self.navigationItem.leftBarButtonItems = [negativeSpacer, leftBarButton]
        
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.registerClass(FilterViewCell.self, forCellReuseIdentifier: "MealTypeTableCell")
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
