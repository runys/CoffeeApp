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
        // Configure the user interactions first.
//      self.configureUserInteractions()

        registerForPushNotifications(application)
    

        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            let aps = notification["aps"] as! [String: AnyObject]
           _ =  DealDAO.makeDeal(aps)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshDeal"), object: self)
        }
        
        // Register with APNs
        return true
    }
    
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
        let viewAction = UNNotificationAction(identifier: "viewAction", title: "View", options: [.authenticationRequired, .foreground])
        let dismissAction = UNNotificationAction(identifier: "dismissAction", title: "Dismiss", options: [.authenticationRequired])
        
        // Set up categories.
        let dealCategory = UNNotificationCategory(identifier: "dealCategory", actions: [viewAction, dismissAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([dealCategory])
        
        application.registerForRemoteNotifications()
        
    }
    
    

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
//       let aps = userInfo["aps"] as! [String: AnyObject]
//       _ = DealDAO.makeDeal(aps)
//       NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshDeal"), object: self)
//        (window?.rootViewController as? UITabBarController)?.selectedIndex = 2

    }
    
    
    // Handle remote notification registration.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        // Forward the token to your provider, using a custom method.
        self.enableRemoteNotificationFeatures()
        self.forwardTokenToServer(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // The token is not currently available.
        print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
        self.disableRemoteNotificationFeatures()
    }
    


    
    func forwardTokenToServer(deviceToken: Data){
//         Convert token to string.
         let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
//         Log the token string.
         print("ExampleNotificationApp: APNs device token - \(deviceTokenString)")
        
    }
    

//
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Allowing banners to show up in the app.
        
//        let aps =  notification.request.content.userInfo as! [String: AnyObject]
//        DealDAO.makeDeal(aps)
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshDeal"), object: self)
//        (window?.rootViewController as? UITabBarController)?.selectedIndex = 2
        
        completionHandler([.alert, .sound])
    }


//    handling the notification and perform actions in reply of the user choosen action
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
//        if response.actionIdentifier ==  "viewAction" {
//            let aps = response.notification.request.content.userInfo["aps"] as! [String : AnyObject]
//            _ =  DealDAO.makeDeal(aps)
//            (window?.rootViewController as? UITabBarController)?.selectedIndex = 2
//
//        } else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
//
//        } else {
//            print("No custom action identifiers chosen")
//        }
//        completionHandler()
//    }
    
    
    func disableRemoteNotificationFeatures(){
        
    }
    
    
    func enableRemoteNotificationFeatures(){
        
    }
    
    
}

