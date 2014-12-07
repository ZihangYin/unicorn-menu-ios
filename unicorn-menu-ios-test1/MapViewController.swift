//
//  MapViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/6/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var userLocation = UserLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
        var leftButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        leftButton.setImage(UIImage(named: "filter.png"), forState: UIControlState.Normal)
        leftButton.frame = CGRectMake(0.0, 0.0, 64, 64);
        leftButton.addTarget(self, action: "leftButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        let leftNegativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        leftNegativeSpacer.width = -25
        self.navigationItem.leftBarButtonItems = [leftNegativeSpacer, leftBarButton]
        
        var rightButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        rightButton.setImage(UIImage(named: "scan.png"), forState: UIControlState.Normal)
        rightButton.frame = CGRectMake(0.0, 0.0, 50, 50);
        rightButton.addTarget(self, action: "gridPressed", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButton = UIBarButtonItem.init(customView: rightButton)
        let rightNegativeSpacer: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target:nil, action:nil)
        rightNegativeSpacer.width = -15
        self.navigationItem.rightBarButtonItems = [rightNegativeSpacer, rightBarButton]
        
        var mapView = MKMapView(frame: self.view.frame)
        self.view.addSubview(mapView)
        
        let center = self.userLocation.location.coordinate
        let span = MKCoordinateSpanMake(0.01, 0.01)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftButtonPressed() -> Void {
        (self.navigationController!.delegate as DiscoverNavigationControllerDelegate).interactiveTransition = nil
        self.navigationController!.pushViewController(FilterViewController(), animated: true)
    }
    
    func gridPressed() -> Void {
//        UIView.transitionWithView(self.navigationController!.view, duration: 0.5, options: .TransitionFlipFromRight, animations: {
//            self.navigationController!.popViewControllerAnimated(false)
//            }, completion: nil)
//
//        UIView.transitionWithView(self.navigationController!.view, duration: 0.5, options: .TransitionFlipFromLeft, animations: {
//            }, completion: nil)
        self.navigationController!.popViewControllerAnimated(true)
        
//        UIView.transitionWithView(self.navigationController!.view, duration: 0.5, options: .TransitionFlipFromRight, animations: { () -> Void in
//            self.navigationController!.popViewControllerAnimated(false)
//        }, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
