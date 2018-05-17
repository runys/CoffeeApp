//
//  CoffeeRemindersDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 14/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation
import  UserNotifications

typealias CoffeeReminder = (coffeeID: String, coffeeName: String, hour: Int, minutes: Int)

class CoffeeRemindersDAO {
    
    static func getAllReminders(completionHandler: @escaping ([CoffeeReminder]) -> Void) {
        // TODO: Explain
        NotificationCenterManager.shared.getAllNotifications { (notificationRequests) in
            var coffeeReminders: [CoffeeReminder] = []
            
            for notification in notificationRequests where notification.content.categoryIdentifier == NotificationCategoryIdentifier.reminder {
                let coffeeName = notification.content.userInfo["coffeeName"] as? String ?? ""
                let coffeeID = notification.content.userInfo["coffeeID"] as? String ?? ""

                let trigger = notification.trigger as! UNCalendarNotificationTrigger
                
                let coffeReminder: CoffeeReminder = (coffeeID: coffeeID,
                                                     coffeeName: coffeeName,
                                                     hour: trigger.dateComponents.hour ?? 0,
                                                     minutes: trigger.dateComponents.minute ?? 0)
                coffeeReminders.append(coffeReminder)
            }
            
            completionHandler(coffeeReminders)
        }
    }
    
    static func createReminder(hour: Int, minute: Int, coffeeID: String) {
        let coffee = CoffeeDAO.getCoffee(coffeeID)!
        let notificationIdentifier = "\(coffee.name)\(hour)\(minute)"
        
        let notificationSettings =
            CoffeeReminderNotificationContent(title: "Coffee time!",
                                              bodyText: "It is time to drink a \(coffee.name).",
                                              hour: hour,
                                              minutes: minute,
                                              requestUniqueIdentifier: notificationIdentifier,
                                              info: ["coffeeName": coffee.name, "coffeeID": coffee.id])
        
        NotificationCenterManager.shared
            .createReminderNotificationWith(notificationContent: notificationSettings)
        
        print("[LOG] Reminder created: \(hour):\(minute) for \(coffee.name)")
    }
    
    static func deleteReminder(_ reminder: CoffeeReminder) {
        let notificationIdentifier = "\(reminder.coffeeName)\(reminder.hour)\(reminder.minutes)"
        
        NotificationCenterManager.shared.removeNotification(with: notificationIdentifier)
    }
}
