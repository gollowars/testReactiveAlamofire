//
//  AppDelegate.swift
//  TestAlamofire
//
//  Created by Yoshizumi Ashikawa on 2016/02/19.
//  Copyright © 2016年 Yoshizumi Ashikawa. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var mainView: ViewController!

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow()
		window?.makeKeyAndVisible()

		mainView = ViewController()
    window?.rootViewController = mainView
    return true
  }

}

