//
//  AppDelegate.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    return true
  }
  
  func application(app: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
    guard let _ = url.host else { return true }
    
    let urlString = url.absoluteString
    let urlArray = urlString.componentsSeparatedByString("/")
    guard urlArray.count >= 4 else { return true }
    let urlTypeIndex = 2
    let urlType = urlArray[urlTypeIndex]
    
    guard let _ = urlType.rangeOfString("puzzle") else { return true }
    let puzzleNameIndex = 3
    let puzzleName = urlArray[puzzleNameIndex]
    guard let gameViewController = self.window?.rootViewController as? GameViewController where !puzzleName.isEmpty else { return true }
    gameViewController.deepLink(puzzleName)
    
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