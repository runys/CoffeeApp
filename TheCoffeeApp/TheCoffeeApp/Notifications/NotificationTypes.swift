//
//  NotificationTypes.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

struct CoffeeReminderNotificationContent {
    // Notification content
    let title: String
    let bodyText: String
    
    // Trigger parameters
    let hour: Int
    let minutes: Int
    let repeating: Bool = true
    
    // Identifiers
    let requestUniqueIdentifier: String
    
    let categoryIdentifier: String = NotificationCategoryIdentifier.reminder
    
    let threadIdentifier: String = NotificationThreadIdentifier.coffeeReminder
    
    // User information
    var info = [
        "coffeeName": "",
        "coffeeID": ""
    ]
}

struct ProximityNotificationContent {
    // Notification content
    let title: String
    let bodyText: String
    
    // Trigger parameters
    let latitude: Double
    let longitude: Double
    let radiusInMeters: Double
    let locationIdentifier: String
    
    // Identifiers
    let requestUniqueIdentifier: String
    
    let categoryIdentifier: String = NotificationCategoryIdentifier.proximity
    
    let threadIdentifier: String = NotificationThreadIdentifier.coffeBarNearby
    
    // User information
    var info = [
        "coffeeBarName": "",
        "coffeeBarID": ""
    ]
}
