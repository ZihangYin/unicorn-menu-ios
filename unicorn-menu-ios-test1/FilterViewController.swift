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
        self.view.backgroundColor = UIColor.whiteColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 100
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 100
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//        
//        var imageView: UIImageView? = cell.viewWithTag(10) as? UIImageView
//        if(indexPath.row == 0){
//            imageView!.image = UIImage(named: "profile.jpg")
//        }else{
//            imageView!.image = UIImage(named: String(indexPath.row))
//        }
//        
//        var textLabel: UILabel? = cell.viewWithTag(11) as? UILabel
//        textLabel!.text! = list[indexPath.row]
//        return  cell;
//    }
//    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        var footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 100))
//        footerView.backgroundColor = UIColor.clearColor()
//        var textLabel = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.bounds.size.width, height: 50))
//        
//        textLabel.text = "Powered by Zihang Yin"
//        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
//        textLabel.textAlignment = .Center
//        textLabel.textColor = UIColor.whiteColor()
//        
//        footerView.addSubview(textLabel)
//        
//        return footerView
//    }
//    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
