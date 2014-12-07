//
//  FilterViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/12/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@objc protocol FilterTableViewDelegate: UITableViewDelegate {
    func ifAnyItemisChecked(tableView: UITableView) -> Bool
}

class FilterViewController: UIViewController, UITableViewDataSource, FilterTableViewDelegate {
    
    var filterView = FilterView(frame: CGRectZero)
    
    var foodCategories = [FilterCell(name: "Anything", checked: true), FilterCell(name: "American"), FilterCell(name: "Chinese"), FilterCell(name: "French"), FilterCell(name: "German"), FilterCell(name: "Greek"),
        FilterCell(name: "Indian"), FilterCell(name: "Italian"), FilterCell(name: "Japanese"), FilterCell(name: "Korean"), FilterCell(name: "Taiwanese"), FilterCell(name: "Thai"), FilterCell(name: "Vietnamese")]
    
    var mealTypes = [FilterCell(name: "Anytime", checked: true), FilterCell(name: "Breakfast"), FilterCell(name: "Brunch"), FilterCell(name: "Lunch"), FilterCell(name: "Happy Hour"), FilterCell(name: "Dinner")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Filter"
        
        self.filterView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(filterView)
        
        self.filterView.btnOne.addTarget(self, action: "buttonOnePressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.filterView.btnArrowOne.addTarget(self, action: "buttonOnePressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.filterView.btnTwo.addTarget(self, action: "buttonTwoPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.filterView.btnArrowTwo.addTarget(self, action: "buttonTwoPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.filterView.btnThree.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.filterView.btnFour.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        autoLayoutSubviews()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIButton.buttonWithType(UIButtonType.Custom) as UIButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var foodCategoriesSelected = String()
        for foodCategory in foodCategories {
            if (foodCategory.checked) {
                if !foodCategoriesSelected.isEmpty {
                    foodCategoriesSelected += ", "
                }
                foodCategoriesSelected += foodCategory.itemName
            }
        }
        
        var mealTypesSelected = String()
        for mealType in mealTypes {
            if (mealType.checked) {
                if !mealTypesSelected.isEmpty {
                    mealTypesSelected += ", "
                }
                mealTypesSelected += mealType.itemName
            }
        }
        
        self.filterView.btnOne.setTitle(foodCategoriesSelected, forState: UIControlState.Normal)
        self.filterView.btnTwo!.setTitle(mealTypesSelected, forState: UIControlState.Normal)
    }
    
    func buttonOnePressed() {
        let foodCategoryViewController = FoodCategoryViewController()
        foodCategoryViewController.tableView.tag = 1
        foodCategoryViewController.tableView.delegate = self
        foodCategoryViewController.tableView.dataSource = self
        self.navigationController!.pushViewController(foodCategoryViewController, animated: true)
    }
    
    func buttonTwoPressed() {
        let mealTypeViewController = MealTypeViewController()
        mealTypeViewController.tableView.tag = 2
        mealTypeViewController.tableView.delegate = self
        mealTypeViewController.tableView.dataSource = self
        self.navigationController!.pushViewController(mealTypeViewController, animated: true)
    }
    
    func backButtonPressed() {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return foodCategories.count
        } else {
            return mealTypes.count
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var tappedCell: FilterCell!
        if tableView.tag == 1 {
            tappedCell = self.foodCategories[indexPath.row]
            tappedCell.checked = !tappedCell.checked
            if (indexPath.row == 0) {
                if tappedCell.checked == true {
                    for index in 1 ..< foodCategories.count {
                        foodCategories[index].checked = false
                    }
                }
            } else {
                if (self.foodCategories[0].checked == true) {
                    self.foodCategories[0].checked = false
                }
            }
        } else {
            tappedCell = self.mealTypes[indexPath.row]
            tappedCell.checked = !tappedCell.checked
            if (indexPath.row == 0) {
                if tappedCell.checked == true {
                    for index in 1 ..< mealTypes.count {
                        mealTypes[index].checked = false
                    }
                }
            } else {
                if (self.mealTypes[0].checked == true) {
                    self.mealTypes[0].checked = false
                }
            }
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: FilterViewCell!
        if tableView.tag == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("FoodCategoryTableCell") as FilterViewCell!
            var foodCategory = foodCategories[indexPath.item]
            cell.label.text = foodCategory.itemName
            if foodCategory.checked {
                cell.checkView.image = UIImage(named: "check_red.png")
                cell.label.textColor = UIColor.redColor()
            } else {
                cell.checkView.image = nil
                cell.label.textColor = UIColor.darkGrayColor()
            }
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("MealTypeTableCell") as FilterViewCell!
            var mealType = mealTypes[indexPath.item]
            cell.label.text = mealType.itemName
            if mealType.checked {
                cell.checkView.image = UIImage(named: "check_red.png")
                cell.label.textColor = UIColor.redColor()
            } else {
                cell.checkView.image = nil
                cell.label.textColor = UIColor.darkGrayColor()
            }
        }
        cell.setNeedsLayout()
        return cell
    }
    
    func ifAnyItemisChecked(tableView: UITableView) -> Bool {
        if tableView.tag == 1 {
            for foodCategory in foodCategories {
                if (foodCategory.checked) {
                    return true
                }
            }
        } else {
            for mealType in mealTypes {
                if (mealType.checked) {
                   return true
                }
            }
        }

        return false
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "filterView": self.filterView]
        let filterView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[filterView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let filterView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[filterView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(filterView_constraint_H)
        self.view.addConstraints(filterView_constraint_V)
    }
}
