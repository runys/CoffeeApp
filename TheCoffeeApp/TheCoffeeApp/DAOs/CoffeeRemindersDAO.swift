//
//  CoffeeRemindersDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 14/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class CoffeeRemindersDAO {
    
    static func getAllReminders() {
        // TODO: 
    }
    
    static func createReminder(hour: Int, minute: Int, coffeeID: String) {
        let coffee = CoffeeDAO.getCoffee(coffeeID)
        
        print("[LOG] Reminder created: \(hour):\(minute) for \(coffee!.name)")
    }
    
    static func deleteReminder(identifier: String) {
        // TODO:
    }
    
}
