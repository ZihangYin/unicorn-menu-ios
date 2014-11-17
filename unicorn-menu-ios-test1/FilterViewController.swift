//
//  FilterViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/12/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    //}, UITableViewDataSource, UITableViewDelegate {

    let list = ["Gianluca Tursi", "Home", "Camera", "Rures", "Games", "Settings"]
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.greenColor()
        self.view.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var imageView: UIImageView? = cell.viewWithTag(10) as? UIImageView
        if(indexPath.row == 0){
            imageView!.image = UIImage(named: "profile.jpg")
        }else{
            imageView!.image = UIImage(named: String(indexPath.row))
        }
        
        var textLabel: UILabel? = cell.viewWithTag(11) as? UILabel
        textLabel!.text! = list[indexPath.row]
        return  cell;
    }
}
