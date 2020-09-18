//
//  AppDelegate.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var notificationScheduler: NotificationScheduler!
    private var autoSessionOpener: AutoSessionOpenerImpl!
    private var autoSessionCloser: AutoSessionCloserImpl!

    override init() {
        Logger.plant(OsLogLogger.instance)
        FirebaseApp.configure()
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        FirebaseApp.configure()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRemoteLogger()
        setupNotifications()
        setupSessionManagers()
        return true
    }

    private func setupRemoteLogger() {
        let remoteLogger = SwinjectStoryboard.defaultContainer.resolve(RemoteLogger.self)!
        let sumoUploader = SwinjectStoryboard.defaultContainer.resolve(SumoUploader.self)!
        remoteLogger.attach(uploader: sumoUploader)
        Logger.plant(remoteLogger)
    }

    private func setupNotifications() {
        notificationScheduler = SwinjectStoryboard.defaultContainer.resolve(NotificationScheduler.self)
        notificationScheduler.start()
    }

    private func setupSessionManagers() {
        autoSessionOpener = SwinjectStoryboard.defaultContainer.resolve(AutoSessionOpenerImpl.self)
        autoSessionCloser = SwinjectStoryboard.defaultContainer.resolve(AutoSessionCloserImpl.self)
        autoSessionOpener.start()
        autoSessionCloser.start()
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

