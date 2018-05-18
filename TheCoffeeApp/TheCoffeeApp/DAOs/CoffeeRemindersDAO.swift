////
////  CoffeeRemindersDAO.swift
////  TheCoffeeApp
////
////  Created by Tiago Pereira on 14/05/2018.
////  Copyright © 2018 Apple Developer Academy. All rights reserved.
////
//
//import Foundation
//import  UserNotifications
//
//typealias CoffeeReminder = (coffeeID: String, coffeeName: String, hour: Int, minutes: Int)
//
//class CoffeeRemindersDAO {
//    // - MARK: 1 - Get all notifications of a category
//    // Get all the notifications with the reminder category
//    static func getAllReminders(completionHandler: @escaping ([CoffeeReminder]) -> Void) {
//        // 1. Get all the notifications
//        //  The completion handler is how you give the information back
//        //  because the .getAllNotifications method is asyncronous.
//        NotificationCenterManager.shared.getAllNotifications { (notificationRequests) in
//            // 2. An array with a custom type CoffeeReminder
//            var coffeeReminders: [CoffeeReminder] = []
//            
//            // 3. Filter all the notification with the Reminder category identifier
//            for notification in notificationRequests where notification.content.categoryIdentifier == NotificationCategoryIdentifier.reminder {
//                let coffeeName = notification.content.userInfo["coffeeName"] as? String ?? ""
//                let coffeeID = notification.content.userInfo["coffeeID"] as? String ?? ""
//
//                let trigger = notification.trigger as! UNCalendarNotificationTrigger
//                // 4. Creates a CoffeeReminder object
//                let coffeReminder: CoffeeReminder = (coffeeID: coffeeID,
//                                                     coffeeName: coffeeName,
//                                                     hour: trigger.dateComponents.hour ?? 0,
//                                                     minutes: trigger.dateComponents.minute ?? 0)
//                // 5. Append it to the array we are going to return at the end
//                coffeeReminders.append(coffeReminder)
//            }
//            // 6. Return the array with all the Reminder notifications
//            completionHandler(coffeeReminders)
//        }
//    }
//    
//    // - MARK: 2 - Create a Reminder notification
//    static func createReminder(hour: Int, minute: Int, coffeeID: String) {
//        let coffee = APIManager.shared.getCoffee(coffeeID)!
//        // 1. Create the notification unique identifier
//        let notificationIdentifier = "\(coffee.name)\(hour)\(minute)"
//        // 2. Set up the content of the notification with a custom structure
//        let notificationSettings =
//            CoffeeReminderNotificationContent(title: "Coffee time!",
//                                              bodyText: "It is time to drink a \(coffee.name).",
//                                              hour: hour,
//                                              minutes: minute,
//                                              requestUniqueIdentifier: notificationIdentifier,
//                                              info: ["coffeeName": coffee.name, "coffeeID": coffee.id])
//        // 3. Create a Reminder notification
//        NotificationCenterManager.shared
//            .createReminderNotificationWith(notificationContent: notificationSettings)
//        
//        print("[LOG] Reminder created: \(hour):\(minute) for \(coffee.name)")
//    }
//    
//    static func deleteReminder(_ reminder: CoffeeReminder) {
//        let notificationIdentifier = "\(reminder.coffeeName)\(reminder.hour)\(reminder.minutes)"
//        
//        NotificationCenterManager.shared.removeNotification(with: notificationIdentifier)
//    }
//}
