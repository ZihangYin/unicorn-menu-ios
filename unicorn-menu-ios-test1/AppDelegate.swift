//
//  AppDelegate.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/7/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var scanWindow: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.scanWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.scanWindow!.rootViewController =  QRCodeScannerViewController()
        self.scanWindow?.makeKeyAndVisible()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.darkGrayColor();
        
        var discoverNavigationController = DiscoverNavigationController.init(navigationBarClass: DiscoverNavigationBarView.self, toolbarClass: nil)
        discoverNavigationController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "ProximaNova-Regular", size:17)!]
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barStyle = .Black
        
        let discoverLayout: CollectionViewWaterfallFlowLayout = CollectionViewWaterfallFlowLayout()
        discoverLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        discoverLayout.columnCount = 2
//        discoverLayout.headerHeight = 30
        discoverLayout.minimumColumnSpacing = 7
        discoverLayout.minimumInteritemSpacing = 7
        discoverNavigationController.pushViewController(DiscoverViewController(collectionViewLayout: discoverLayout), animated: false)
        
        self.window!.rootViewController = discoverNavigationController
        self.window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

