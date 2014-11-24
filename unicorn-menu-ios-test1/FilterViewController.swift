//
//  FilterViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/12/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var filterView: FilterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "FILTER"
        
        self.filterView = FilterView(frame: self.view.frame)
        self.filterView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(filterView!)
      
        self.filterView!.btnThree.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.filterView!.btnFour.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        autoLayoutSubviews()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIButton.buttonWithType(UIButtonType.Custom) as UIButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)        
       
    }
    
    func backButtonPressed() {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["topLayoutGuide": self.topLayoutGuide, "filterView": self.filterView!]
        let filterView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[filterView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let filterView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[filterView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(filterView_constraint_H)
        self.view.addConstraints(filterView_constraint_V)
    }
}
