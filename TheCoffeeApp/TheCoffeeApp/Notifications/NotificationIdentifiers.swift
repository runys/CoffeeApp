//
//  NotificationIdentifiers.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 16/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

// Content agnostic
public struct NotificationCategoryIdentifier {
    // Reminds you of something
    static let reminder: String = "reminderNotification"
    
    // Notify when you are nearby somewhere
    static let proximity: String = "proximityNotification"
}

// Content specific
struct NotificationThreadIdentifier {
    static let coffeeReminder: String = "coffeeReminderNotification"
    static let coffeBarNearby: String = "coffeeBarNearbyNotification"
    static let update: String = "updateNotification"
}

public struct NotificationActionIdentifier {
    static let didDrinkCoffee: String = "drinkCoffee"
    static let didntDrinkCoffee: String = "dontDrinkCofee"
}
