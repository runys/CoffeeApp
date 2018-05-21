//
//  ApiManager.swift
//  TheCoffeeApp
//
//  Created by Massimiliano Di Mella on 18/05/18.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation
import UserNotifications

fileprivate var MINIMUN_NEARBY_DISTANCE: Double = 1
typealias CoffeeReminder = (coffeeID: String, coffeeName: String, hour: Int, minutes: Int)


class APIManager {
    static let shared: APIManager = APIManager()
    private var coffee: [Coffee] = [espresso, doubleEspresso, ristretto, cappuccino, americano, latte,macchiato, mocha, caffeNocciola, cioccolattaCalda]
    private var tips: [Tip] = [tip1, tip2, tip3]

    private var coffeeShops: [CoffeeShop] = [universityBar, barLorenzo, barMexico, barProfessore, caffeGambrinus]
    private var deals: [Deal] = [deal1, deal2, deal3, deal4]
    private var drinkHistory: [DrinkRecord] = [record1, record2, record3, record4]
    
    // - MARK: GETs APIs
    
    func getAllCoffeShops() -> [CoffeeShop] {
        return coffeeShops
    }
    
    func getCoffeShopBy(_ idCoffeShop: String) -> CoffeeShop? {
        return coffeeShops.filter({ (coffeShopItem: CoffeeShop) -> Bool in
            return coffeShopItem.id == idCoffeShop
        }).first
    }
    
    func getAll(splitedByMinimum distance: Double) -> [String: [CoffeeShop]] {
        var coffeeBars: [String: [CoffeeShop]] = ["NEARBY" : [], "OTHERS" : []]
        
        for coffeeBar in coffeeShops {
            if coffeeBar.distanceFromYou < MINIMUN_NEARBY_DISTANCE {
                coffeeBars["NEARBY"]?.append(coffeeBar)
            } else {
                coffeeBars["OTHERS"]?.append(coffeeBar)
            }
        }
        return coffeeBars
    }
    
    func getAllCoffees() -> [Coffee] {
        return coffee
    }
    
    func getCoffee(_ id: String) -> Coffee? {
        let coffee = self.coffee.first { (coffee) -> Bool in
            return coffee.id == id
        }
        return coffee
    }
    
    func getAllTips() -> [Tip] {
        return tips
    }
    
    func getAllDeals() -> [Deal] {
        return deals
    }
    
    func getHistory() -> [DrinkRecord] {
        return drinkHistory
    }
    
     func getAllReminders(completionHandler: @escaping ([CoffeeReminder]) -> Void) {
        
        // 1. Get all the notifications
        //  The completion handler is how you give the information back
        //  because the .getAllNotifications method is asyncronous.
        NotificationCenterManager.shared.getAllNotifications { (notificationRequests) in
        
            // 2. An array with a custom type CoffeeReminder
            var coffeeReminders: [CoffeeReminder] = []
            
            // 3. Filter all the notification with the Reminder category identifier
            for notification in notificationRequests where notification.content.categoryIdentifier == NotificationCategoryIdentifier.reminder {
                let coffeeName = notification.content.userInfo["coffeeName"] as? String ?? ""
                let coffeeID = notification.content.userInfo["coffeeID"] as? String ?? ""
                
                let trigger = notification.trigger as! UNCalendarNotificationTrigger
            
                // 4. Creates a CoffeeReminder object
                let coffeReminder: CoffeeReminder = (coffeeID: coffeeID,
                                                     coffeeName: coffeeName,
                                                     hour: trigger.dateComponents.hour ?? 0,
                                                     minutes: trigger.dateComponents.minute ?? 0)
                
                // 5. Append it to the array we are going to return at the end
                coffeeReminders.append(coffeReminder)
            }
            
            // 6. Return the array with all the Reminder notifications
            completionHandler(coffeeReminders)
        }
    }
    
    // - MARK: POST APIs
    
    func makeTip(_ notificationDictionary: [String: AnyObject]) -> Tip? {
        if let subject = notificationDictionary["subject"] as? String,
            let headline = notificationDictionary["headline"] as? String,
            let description = notificationDictionary["description"] as? String{
            let tip = Tip(subject: subject, headline: headline, description: description)
            add(tip)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshTips"), object: self)
            return tip
            
        }
        return nil
    }
    
    func add(_ tip: Tip) {
        tips.append(tip)
    }
    
    func add(_ deal: Deal) {
        deals.append(deal)
    }
    
    
    func addDrinkEntry(coffeeId: String, timestamp: Date, coffeeBar: CoffeeShop?) {
        let coffee = APIManager.shared.getCoffee(coffeeId)!
        let newEntry = DrinkRecord(didDrink: true, coffee: coffee, timestamp: timestamp, place: coffeeBar)
        drinkHistory.append(newEntry)
        print("[LOG] New drink entry \(coffee.name) at \(timestamp.description)")
        EventsManager.shared.postEvent("newDrinkEntry")
    }
    
    func makeDeal(_ notificationDictionary: [String: AnyObject]) -> Deal? {
        guard let coffeShopId = notificationDictionary["coffeShopId"] as? String else { return nil }
        guard let coffeShop = getCoffeShopBy(coffeShopId) else { return nil }
        let deal = Deal(store: coffeShop,
                        coffee: coffeShop.coffees[0].coffee,
                        previousPrice: coffeShop.coffees[0].price,
                        newPrice: coffeShop.coffees[0].price * 0.8)
        add(deal)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshDeals"), object: self)
        return deal
    }
    
    func createReminder(hour: Int, minute: Int, coffeeID: String) {
        let coffee = APIManager.shared.getCoffee(coffeeID)!
        // 1. Create the notification unique identifier
        let notificationIdentifier = "\(coffee.name)\(hour)\(minute)"
        // 2. Set up the content of the notification with a custom structure
        let notificationSettings =
            CoffeeReminderNotificationContent(title: "Coffee time!",
                                              bodyText: "It is time to drink a \(coffee.name).",
                hour: hour,
                minutes: minute,
                requestUniqueIdentifier: notificationIdentifier,
                info: ["coffeeName": coffee.name, "coffeeID": coffee.id])
        // 3. Create a Reminder notification
        NotificationCenterManager.shared
            .createReminderNotificationWith(notificationContent: notificationSettings)
        
        print("[LOG] Reminder created: \(hour):\(minute) for \(coffee.name)")
    }
    
    func deleteReminder(_ reminder: CoffeeReminder) {
        let notificationIdentifier = "\(reminder.coffeeName)\(reminder.hour)\(reminder.minutes)"
        
        NotificationCenterManager.shared.removeNotification(with: notificationIdentifier)
    }

    // - MARK: Notification APIs

    func setUpLocationNotifications() {
        for coffeeBar in coffeeShops {
            registerProximityNotification(for: coffeeBar)
        }
    }
    
    func registerProximityNotification(for coffeeBar: CoffeeShop) {
        let locationIdentifier = coffeeBar.locationIdentifier
        let requestIdentifier = "ProximityNotificationTo\(coffeeBar.name)"
        
        let notificationSettings: ProximityNotificationContent
            = ProximityNotificationContent(title: "A coffee bar is near!",
                                           bodyText: "Why don't you stop by \(coffeeBar.name) and drink a \(coffeeBar.topThreeCoffees[0].name)?",
                latitude: coffeeBar.location.latitude,
                longitude: coffeeBar.location.longitude,
                radiusInMeters: 100,
                locationIdentifier: locationIdentifier,
                requestUniqueIdentifier: requestIdentifier,
                info: ["coffeeBarName": coffeeBar.name, "coffeeBarID": coffeeBar.id])
        
        NotificationCenterManager.shared
            .registerProximityNotification(notificationContent: notificationSettings)
    }
    
}
