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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
         application.applicationIconBadgeNumber = 0
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Setting up the class that handles the notifications
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = NotificationCenterManager.shared
        
        // Request authorization to display notifications
        NotificationCenterManager.shared.requestAuthorizationForNotifications()
        
        // Register with APNs
        registerForPushNotifications(application)
        
        // Set up notification actions.
        self.registerCoffeeDealNotificationActions()
        self.registerCoffeeRemindersNotificationActions()
        
        // Set up the app color palette into Navigation and Tab bars
        self.setUpColorPalette()
        
        return true
    }
    
    //
    func registerForPushNotifications(_ application: UIApplication) {
        application.registerForRemoteNotifications()
    }
    
    
}

// - MARK: Handling remote notifications
extension AppDelegate {
    
    // Handle remote notification registration.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        // Forward the token to your provider, using a custom method.
        self.forwardTokenToServer(deviceToken: deviceToken)
    }
    
    // TODO: Explain what it is
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
    
    // TODO: Explain what it is
    func forwardTokenToServer(deviceToken: Data){
        // Convert token to string.
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        // Log the token string.
        print("APNs device token - \(deviceTokenString)")
    }
    
    // TODO: Explain what it is
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // The token is not currently available.
        print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
        self.disableRemoteNotificationFeatures()
    }

    // TODO: Explain what it is
    func disableRemoteNotificationFeatures(){
        //  disable Remote Notification Features, if needed
    }
}

// - MARK: Register notification actions
extension AppDelegate {
    // TODO: Explain what it is
    func registerCoffeeDealNotificationActions() {
        // 1.
        let likeAction =
            UNNotificationAction(identifier: "likeAction",
                                 title: "Like",
                                 options: [.authenticationRequired, .foreground])
        
        let dislikeAction =
            UNNotificationAction(identifier: "dislikeAction",
                                 title: "Dislike",
                                 options: [.authenticationRequired, .foreground])
        
        let commentAction =
            UNTextInputNotificationAction(identifier: "comment-action",
                                          title: "Comment",
                                          options: [.authenticationRequired, .foreground],
                                          textInputButtonTitle: "Post",
                                          textInputPlaceholder: "Comment")
        
        // 2.
        let dealCategory =
            UNNotificationCategory(identifier: "dealCategory",
                                   actions: [likeAction,dislikeAction, commentAction],
                                   intentIdentifiers: [],
                                   options: [])
        
        // 3.
        UNUserNotificationCenter.current()
            .setNotificationCategories([dealCategory])
    }
    
    // TODO: Explain what it is
    func registerCoffeeRemindersNotificationActions() {
        // 1.
        let drinkCoffee =
            UNNotificationAction(identifier: "drinkCoffee",
                                 title: "",
                                 options: [.authenticationRequired])
        let dontDrinkCoffee =
            UNNotificationAction(identifier: "dontDrinkCofee",
                                 title: "",
                                 options: [.authenticationRequired])
        
        // 2.
        let reminderCategory =
            UNNotificationCategory(identifier: NotificationCategoryIdentifier.reminder,
                                   actions: [drinkCoffee, dontDrinkCoffee],
                                   intentIdentifiers: [],
                                   options: [])
        // 3.
        UNUserNotificationCenter.current()
            .setNotificationCategories([reminderCategory])
    }
}

// - MARK: Custom methods
extension AppDelegate {
    
    private func setUpColorPalette() {
        window?.tintColor = ColorPallete.darkBackground
        
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.tintColor = ColorPallete.darkPrimary
        
        let tabBarAppearance = UITabBar.appearance()
        
        tabBarAppearance.tintColor = ColorPallete.darkBackground
    }
    
}
