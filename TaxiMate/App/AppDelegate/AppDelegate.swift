//
//  AppDelegate.swift
//  HSD
//
//  Created by rightmeow on 12/12/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RealmManagerDelegate {

    var window: UIWindow?
    var realmManager: RealmManager?
    var sessions: Results<Session>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        setupRealm()
        self.setupRealmManagerDelegate()
        self.realmManager?.fetchSession()
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

    // MARK: - RealmManagerDelegate

    func realmManager(_ manager: RealmManager, didErr error: Error) {
        print(error.localizedDescription)
    }

    private func setupRealmManagerDelegate() {
        self.realmManager = RealmManager()
        self.realmManager!.delegate = self
    }

    func realmManager(_ manager: RealmManager, didFetchSessions sessions: Results<Session>?) {
        if let expired_at = sessions?.first?.expired_at {
            let today = Date()
            if today > expired_at as Date {
                print("go straight to the app")
            } else {
                print("ask the user to login or register")
            }
        }
    }

}

