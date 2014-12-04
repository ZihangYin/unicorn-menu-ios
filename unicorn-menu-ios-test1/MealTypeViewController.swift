//
//  MealTypeViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/4/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class MealTypeViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var mealTypes = [FilterCell(name: "Breakfast"), FilterCell(name: "Brunch"), FilterCell(name: "Lunch"), FilterCell(name: "Happy Hour"), FilterCell(name: "Dinner")]
    
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return mealTypes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealTypeTableCell") as FilterViewCell!
        var mealType = mealTypes[indexPath.item]
        cell.label.text = mealType.itemName
        cell.accessoryType = .None
        if mealType.checked {
            cell.checkView.image = UIImage(named: "check_red.png")
            cell.label.textColor = UIColor.redColor()
        } else {
            cell.checkView.image = nil
            cell.label.textColor = UIColor.darkGrayColor()
        }
        cell.setNeedsLayout()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var tappedType = self.mealTypes[indexPath.row]
        tappedType.checked = !tappedType.checked
        tableView.reloadData()
    }

    func backButtonPressed() {
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = nil
        self.navigationController!.popViewControllerAnimated(true)
    }

}
