//
//  CoffeeRemindersDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 14/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation
import  UserNotifications

typealias CoffeeReminder = (coffeeName: String, hour: Int, minutes: Int)

class CoffeeRemindersDAO {
    
    static func getAllReminders(completionHandler: @escaping ([CoffeeReminder]) -> Void) {
        // TODO:
        NotificationCenterManager.shared.getAllNotifications { (notificationRequests) in
            var coffeeReminders: [CoffeeReminder] = []
            
            for notification in notificationRequests where notification.content.categoryIdentifier == NotificationCategoryIdentifier.reminder {
                let coffeeName = notification.content.userInfo["coffeeName"] as? String ?? ""
                let trigger = notification.trigger as! UNCalendarNotificationTrigger
                
                let coffeReminder: CoffeeReminder = (coffeeName: coffeeName,
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
        
        let notificationTitle = "Coffee time!"
        let notificationBody = "It is time to drink a \(coffee.name)."
        
        NotificationCenterManager.shared
            .createReminderNotificationWith(title: notificationTitle, bodyText: notificationBody, hour: hour, minutes: minute, identifier: notificationIdentifier, info: ["coffeeName": coffee.name])
        
        print("[LOG] Reminder created: \(hour):\(minute) for \(coffee.name)")
    }
    
    static func deleteReminder(hour: Int, minute: Int, coffeeID: String) {
        let coffee = CoffeeDAO.getCoffee(coffeeID)!
        
        let notificationIdentifier = "\(coffee.name)\(hour)\(minute)"
        
        NotificationCenterManager.shared.removeNotification(with: notificationIdentifier)
    }
}
