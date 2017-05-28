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
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
    guard let _ = url.host else { return true }
    
    let urlString = url.absoluteString
    let urlArray = urlString.components(separatedBy: "/")
    guard urlArray.count >= 5 else { return true }
    let urlTypeIndex = 2
    let urlType = urlArray[urlTypeIndex]
    
    guard let _ = urlType.range(of: "puzzle") else { return true }
    let puzzleNameIndex = 3
    let puzzleName = urlArray[puzzleNameIndex]
    let puzzleDifficultyIndex = 4
    let puzzleDifficulty = urlArray[puzzleDifficultyIndex]
    guard
      let difficulty = Int(puzzleDifficulty),
      let gameViewController = window?.rootViewController as? GameViewController,
      !puzzleName.isEmpty else { return true }
    gameViewController.deepLink(withPuzzleName: puzzleName, difficulty: difficulty)
    
    return true
  }
}
