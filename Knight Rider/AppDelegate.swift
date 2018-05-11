//
//  AppDelegate.swift
//  Knight Rider
//
//  Created by Michael on 2/13/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import UserNotifications
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: LoginController())
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyADV1MIme253HQ00HDGbzAHZZKx1Wvso1I")
        GMSPlacesClient.provideAPIKey("AIzaSyADV1MIme253HQ00HDGbzAHZZKx1Wvso1I")
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 99/255, green: 51/255, blue: 147/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error == nil {
                print("Successful authorization.")
            }
        }
        
        application.registerForRemoteNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Messaging.messaging().shouldEstablishDirectChannel = false
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        firebaseHandler()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func refreshToken(notification: NSNotification) {
        let refreshToken = InstanceID.instanceID().token()!
        print(refreshToken)
        
        firebaseHandler()
    }

    func firebaseHandler() {
        Messaging.messaging().shouldEstablishDirectChannel = true
        
    }
}

