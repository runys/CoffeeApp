//
//  DrinkHistoryDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class DrinkHistoryDAO {
    private static var drinkHistoryDatabase: [DrinkRecord] = {
        var drinkHistory: [DrinkRecord] = []
        
        let coffeeShops = CoffeeShopDAO.getAll()
        
        let record1 = DrinkRecord(didDrink: true,
                                  coffee: coffeeShops[0].coffees[0].coffee,
                                  timestamp: Date().addingTimeInterval(TimeInterval(3600)),
                                  place: coffeeShops[0])
        let record2 = DrinkRecord(didDrink: true,
                                  coffee: coffeeShops[0].coffees[0].coffee,
                                  timestamp: Date().addingTimeInterval(TimeInterval(4800)),
                                  place: coffeeShops[1])
        let record3 = DrinkRecord(didDrink: true,
                                  coffee: coffeeShops[0].coffees[0].coffee,
                                  timestamp: Date(),
                                  place: coffeeShops[0])
        let record4 = DrinkRecord(didDrink: true,
                                  coffee: coffeeShops[0].coffees[1].coffee,
                                  timestamp: Date().addingTimeInterval(TimeInterval(12000)),
                                  place: coffeeShops[0])
        
        // Uncomment to placeholder history records
        // drinkHistory.append(contentsOf: [record1, record2, record3, record4])
        
        return drinkHistory
    }()
    
    static func getHistory() -> [DrinkRecord] {
        return drinkHistoryDatabase
    }
    
    static func addDrinkEntry(coffeeId: String, timestamp: Date, coffeeBar: CoffeeShop?) {
        let coffee = CoffeeDAO.getCoffee(coffeeId)!
        let newEntry = DrinkRecord(didDrink: true, coffee: coffee, timestamp: timestamp, place: coffeeBar)
        drinkHistoryDatabase.append(newEntry)
        
        print("[LOG] New drink entry \(coffee.name) at \(timestamp.description)")
        
        EventsManager.shared.postEvent("newDrinkEntry")
    }
}
