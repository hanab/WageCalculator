//
//  AppDelegate.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/12/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //global variable to pass data between viewcontrollers
    var selectedEmployee:Employee?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //setup the root viewcontroller
        let root:EmployeesViewController = EmployeesViewController()
        let MainNavigationController = UINavigationController(rootViewController: root)
        MainNavigationController.navigationBar.barTintColor =  UIColor(red: 31/255, green: 148/255, blue: 206/255, alpha: 1.0)
        
        window =  UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = MainNavigationController
        window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

