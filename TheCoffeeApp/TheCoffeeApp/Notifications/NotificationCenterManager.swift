//
//  NotificationCenterManager.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 14/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation

// - MARK: Notification Center Manager
class NotificationCenterManager: NSObject, UNUserNotificationCenterDelegate {
    
    // Singleton
    public static let shared: NotificationCenterManager = NotificationCenterManager()
    
    // Called before a notification is presented to the user
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        /*
         1. App needs to be in foreground to call this method.
         2. You can get information from the notification before presenting it.
         - Identifier
         - userInfo dictionary
         3. Call completion handler with .alert .sound .badge
         - If you call with nothing, you supress the notification
         */
        
        // Allowing banners to show up in the app.
        completionHandler([.alert, .sound])
    }
    
    // Called after the user interacted with the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        /*
         1. Called when the user interacts with the notification
         2. The response has
         - The notification (.notification)
         - The action triggered (.actionIdentifier)
         - UNNotificationDefaultActionIdentifier
         - UNNotificationDismissActionIdentifier
         - Custom action identifier
         */
        
        let notificationContent = response.notification.request.content
        let actionIdentifier = response.actionIdentifier
        
        print("[LOG] Notification '\(notificationContent.categoryIdentifier)' with action '\(actionIdentifier)'")
        
        switch notificationContent.categoryIdentifier {
        case NotificationCategoryIdentifier.reminder:
            self.handleReminderAction(actionIdentifier, notificationContent)
        case NotificationCategoryIdentifier.proximity:
            break
        default:
            print("[LOG] Unknown notification category: '\(notificationContent.categoryIdentifier)'")
        }
        
        completionHandler()
    }
    
    func handleReminderAction(_ actionIdentifier: String, _ notificationContent: UNNotificationContent) {
        switch actionIdentifier {
        case NotificationActionIdentifier.didDrinkCoffee,
             UNNotificationDefaultActionIdentifier:
            let coffeeID: String = notificationContent.userInfo["coffeeID"] as? String ?? ""
            let timestamp = Date()
            APIManager.shared.addDrinkEntry(coffeeId: coffeeID, timestamp: timestamp, coffeeBar: nil)
        default:
            print("[LOG] No coffee was drank that day.")
        }
    }
}

// - MARK: Managing Notifications
extension NotificationCenterManager {
    
    // Providing access to the application Notification Center
    private var notificationCenter: UNUserNotificationCenter {
        return UNUserNotificationCenter.current()
    }
    
    func requestAuthorizationForNotifications() {
        // Request authorization.
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                fatalError("failed to get authorization for notifications with \(error)")
            }
        }
    }
    
    // Get all the current scheduled notifications
    func getAllNotifications(completionHandler: @escaping ([UNNotificationRequest]) -> Void) {
        self.notificationCenter.getPendingNotificationRequests { notificationRequests in
            print("[LOG] Got \(notificationRequests.count) notifications.")
            completionHandler(notificationRequests)
        }
    }
    
    // Remove a schedule notification
    func removeNotification(with identifier: String) {
        self.notificationCenter
            .removePendingNotificationRequests(withIdentifiers: [identifier])
        
        print("[LOG] Removed notification '\(identifier)'")
    }
    
    // Clear the notification history and all the schedule notifications
    func removeAllNotifications() {
        // 1.
        self.notificationCenter
            .removeAllDeliveredNotifications()
        // 2.
        self.notificationCenter
            .removeAllPendingNotificationRequests()
    }
    
    // Re-schedule a notification
    func rescheduleNotification(with identifier: String, to date: Date) {
        // 1. Get a copy of the notification
        // 2. Remove the notification
        // 3. Modify the notification copy
        // 4. Add the notification copy
    }
    
    private func scheduleNotification(requestIdentifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content,
                                            trigger: trigger)
        
        self.notificationCenter.add(request) { (error) in
            if let error = error {
                print("[LOG] Not possible to schedule the notification due to error: \(error.localizedDescription)")
            } else {
                print("[LOG] Notification \(requestIdentifier) schedule successfully")
            }
        }
    }
    
}

// - MARK: Notification Triggers
extension NotificationCenterManager {
    private func createTimeIntervalTrigger(seconds: Double) -> UNTimeIntervalNotificationTrigger {
        let timeIntervalTrigger =
            UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        
        return timeIntervalTrigger
    }
    
    private func createCalendarTrigger(for hour: Int, minutes: Int, repeating: Bool) -> UNCalendarNotificationTrigger {
        // 1. Set up the time pattern to match
        var matchPattern = DateComponents()
        
        matchPattern.hour = hour
        matchPattern.minute = minutes
        
        // 2. Creates the trigger
        let calendarTrigger =
            UNCalendarNotificationTrigger(dateMatching: matchPattern, repeats: repeating)
        
        return calendarTrigger
    }
    
    private func createLocationTrigger(latitude: Double, longitude: Double, radius: Double, regionIdentifier: String) -> UNLocationNotificationTrigger {
        // 1. The location of the place you want to be notified about
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 2. Radius is the distance in meters from the region
        let region = CLCircularRegion(center: center, radius: radius, identifier: regionIdentifier)
        
        // 3. Set up when you want to be notifed
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        // Create the trigger
        let trigger =
            UNLocationNotificationTrigger(region: region, repeats: true)
        
        return trigger
    }
}

// - MARK: Custom API
extension NotificationCenterManager {
    
    func createReminderNotificationWith(notificationContent: CoffeeReminderNotificationContent) {
        let content = UNMutableNotificationContent()
        
        // 1. Set up th notification content
        content.title = notificationContent.title
        content.body = notificationContent.bodyText
        
        content.userInfo = notificationContent.info
        
        content.categoryIdentifier = notificationContent.categoryIdentifier
        content.threadIdentifier = notificationContent.threadIdentifier
        
        // Default properties
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        // 2. Get the trigger
        let trigger =
            self.createCalendarTrigger(for: notificationContent.hour,
                                       minutes: notificationContent.minutes,
                                       repeating: notificationContent.repeating)
        
        // 3. Schedule the notification
        self.scheduleNotification(requestIdentifier: notificationContent.requestUniqueIdentifier,
                                  content: content,
                                  trigger: trigger)
    }
    
    func registerProximityNotification(notificationContent: ProximityNotificationContent) {
        let content = UNMutableNotificationContent()
        
        // 1. Set up th notification content
        content.title = notificationContent.title
        content.body = notificationContent.bodyText
        
        content.userInfo = notificationContent.info
        
        content.categoryIdentifier = notificationContent.categoryIdentifier
        content.threadIdentifier = notificationContent.threadIdentifier
        
        // Default properties
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        // 2. Get the trigger
        let trigger =
            self.createLocationTrigger(latitude: notificationContent.latitude, longitude: notificationContent.longitude, radius: notificationContent.radiusInMeters, regionIdentifier: notificationContent.locationIdentifier)
        
        // 3. Schedule the notification
        self.scheduleNotification(requestIdentifier: notificationContent.requestUniqueIdentifier, content: content, trigger: trigger)
    }
}
