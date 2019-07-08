//
//  AppDelegate.swift
//  MemeMaker
//
//  Created by Daniel Kilders Díaz on 20.06.19.
//  Copyright © 2019 Daniel Kilders. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Unique instance of the Memes array that will live within the app
    var memes = [
        Meme(bottomString: "breakup", topString: "breakup", originalImage: nil, finalImage: UIImage(named: "breakup")),
        Meme(bottomString: "enamorado", topString: "enamorado", originalImage: nil, finalImage: UIImage(named: "enamorado")),
        Meme(bottomString: "huawei", topString: "huawei", originalImage: nil, finalImage: UIImage(named: "huawei")),
        Meme(bottomString: "nsfw", topString: "nsfw", originalImage: nil, finalImage: UIImage(named: "nsfw")),
        Meme(bottomString: "optimism", topString: "optimism", originalImage: nil, finalImage: UIImage(named: "optimism")),
        Meme(bottomString: "support", topString: "support", originalImage: nil, finalImage: UIImage(named: "support")),
        Meme(bottomString: "stayathome", topString: "stayathome", originalImage: nil, finalImage: UIImage(named: "stayathome")),
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

