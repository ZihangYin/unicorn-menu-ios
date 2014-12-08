//
//  UserLocation.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/6/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import CoreLocation

class UserLocation: NSObject, CLLocationManagerDelegate {
    
    internal class UserLocationManager: NSObject, CLLocationManagerDelegate {
        
        let locationManager: CLLocationManager = CLLocationManager()
        
        var latitude: Double!
        var longitude: Double!
        
        private var requested: Bool = false
        
        func requestLocation() {
            if self.requested {
                return
            }
            
            if (CLLocationManager.locationServicesEnabled())
            {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                // IOS8
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.startUpdatingLocation()
                self.requested = true
            }
        }
        
        func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
            println("error = \(error)")
        }
        
        func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
            self.locationManager.startUpdatingLocation()
            
            self.locationManager.stopUpdatingLocation()
            let location = locations.last as CLLocation
            if location.horizontalAccuracy > 0 {
                self.latitude = location.coordinate.latitude
                self.longitude = location.coordinate.longitude
                
//                let nc = NSNotificationCenter.defaultCenter()
//                nc.postNotificationName("UserLocation/updated", object: nil)
                
                self.locationManager.stopUpdatingLocation()
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(60.0 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), {
                    self.locationManager.startUpdatingLocation()
                })
            }
        }
        
        class var instance: UserLocationManager {
            struct Static {
                static let instance: UserLocationManager = UserLocationManager()
            }
            return Static.instance
        }
        
    }
    
    var manager: UserLocationManager!
    
    override init() {
        manager = UserLocationManager.instance
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    var latitude: Double {
        get {
            return manager.latitude ?? 47.620690
        }
    }
    
    var longitude: Double {
        get {
            return manager.longitude ?? -122.349266
        }
    }
    
    var location: CLLocation {
        get {
            return CLLocation(latitude: self.latitude, longitude: self.longitude)
        }
    }
}