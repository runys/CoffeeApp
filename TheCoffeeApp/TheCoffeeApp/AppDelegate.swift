//
//  AppDelegate.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 16/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit
import UserNotifications
import NotificationCenter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
         application.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Register with APNs
        registerForPushNotifications(application)
        
        //  if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
        //      // code the desired actions
        //  }
        self.setUpColorPalette()
        
        return true
    }
    
    //
    func registerForPushNotifications(_ application: UIApplication) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        // Request authorization.
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                fatalError("failed to get authorization for notifications with \(error)")
            }
        }

        
        // Set up actions.
        let likeAction = UNNotificationAction(identifier: "likeAction", title: "Like", options: [.authenticationRequired, .foreground])
        let dislikeAction = UNNotificationAction(identifier: "dislikeAction", title: "Dislike", options: [.authenticationRequired, .foreground])
        let commentAction = UNTextInputNotificationAction(identifier: "comment-action",
                                                          title: "Comment",
                                                          options: [.authenticationRequired, .foreground],
                                                          textInputButtonTitle: "Post",
                                                          textInputPlaceholder: "Comment")
        
        // Set up categories.
        let dealCategory = UNNotificationCategory(identifier: "dealCategory", actions: [likeAction,dislikeAction, commentAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([dealCategory])
        application.registerForRemoteNotifications()

    }
    
    // Handle remote notification registration.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        // Forward the token to your provider, using a custom method.
        self.forwardTokenToServer(deviceToken: deviceToken)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let userInfo = userInfo as? [String : AnyObject] {
            let aps = userInfo["aps"] as! [String: AnyObject]
            if aps["content-available"] as? Int == 1 {
                if aps["category"] as? String == "tipCategory" {
                    _ =  TipDAO.makeTip(userInfo)
                } else if aps["category"] as? String == "dealCategory" {
                    _ =  DealDAO.makeDeal(userInfo)
                    (window?.rootViewController as? UITabBarController)?.selectedIndex = 2
                }
                completionHandler(.newData)
            }
        }
    }
    
    func forwardTokenToServer(deviceToken: Data){
        // Convert token to string.
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        // Log the token string.
        print("APNs device token - \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // The token is not currently available.
        print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
        self.disableRemoteNotificationFeatures()
    }
    

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Allowing banners to show up in the app.
        completionHandler([.alert, .sound])
    }
    
    private func setUpColorPalette() {
        window?.tintColor = ColorPallete.darkBackground
        
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.tintColor = ColorPallete.darkPrimary
        //navigationBarAppearance.barTintColor = ColorPallete.lightPrimary
        
        
        let tabBarAppearance = UITabBar.appearance()
        
        tabBarAppearance.tintColor = ColorPallete.darkBackground
        //tabBarAppearance.barTintColor = ColorPallete.lightPrimary
        //tabBarAppearance.unselectedItemTintColor = ColorPallete.darkBackground
    }
    
    func disableRemoteNotificationFeatures(){
        //  disable Remote Notification Features, if needed
    }
}

