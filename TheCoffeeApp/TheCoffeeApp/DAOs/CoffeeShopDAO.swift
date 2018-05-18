//
//  CoffeeShopDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

fileprivate var MINIMUN_NEARBY_DISTANCE: Double = 1

class CoffeeShopDAO {
    
    private static var coffeeShops: [CoffeeShop] = [
        CoffeeShop(id: "001",
                   name: "University Bar",
                   location: Location(latitude: 40.8362063, longitude: 14.3061987),
                   imageURL: "coffeebar-placeholder-1",
                   description: "That's a very good coffe bar nearby the Academy. Nunzia is a sweetheart.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("001")!, rating: 1, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("007")!, rating: 2, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("004")!, rating: 3, price: 1.5)
            ]),
        CoffeeShop(id: "002",
                   name: "Bar Lorenzo",
                   location: Location(latitude: 40.8354467, longitude: 14.3042449),
                   imageURL: "coffeebar-placeholder-2",
                   description: "A random placeholder coffee bar to increase the amount of entries in the database.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("001")!, rating: 3, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("007")!, rating: 2, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("002")!, rating: 1, price: 1.5)
            ]),
        CoffeeShop(id: "003",
                   name: "Mexico",
                   location: Location(latitude: 40.8462759, longitude: 14.2515021),
                   imageURL: "coffeebar-placeholder-3",
                   description: "That's a random coffe bar added for testing purposes. Enjoy the randomness.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("005")!, rating: 2, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("006")!, rating: 1, price: 1.9)
            ]),
        CoffeeShop(id: "004",
                   name: "Il Vero Bar del Professore",
                   location: Location(latitude: 40.8462759, longitude: 14.2515021),
                   imageURL: "coffeebar-placeholder-4",
                   description: "A well known coffee bar in the city of Napoli. Home of the famous Cafè Nocciola.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("001")!, rating: 2, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("009")!, rating: 1, price: 1.5),
                    (coffee: CoffeeDAO.getCoffee("006")!, rating: 4, price: 1.0),
                    (coffee: CoffeeDAO.getCoffee("007")!, rating: 3, price: 0.9)
            ]),
        CoffeeShop(id: "005",
                   name: "Gran Caffè Gambrinus",
                   location: Location(latitude: 40.8462759, longitude: 14.2515021),
                   imageURL: "coffeebar-placeholder-5",
                   description: "A well known coffee bar in the city of Napoli. Rich people loves this place.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("007")!, rating: 2, price: 1.5),
                    (coffee: CoffeeDAO.getCoffee("009")!, rating: 1, price: 1.5),
                    (coffee: CoffeeDAO.getCoffee("001")!, rating: 3, price: 1.5)
            ])
    ]
    
    static func getAll() -> [CoffeeShop] {
        return coffeeShops
    }
    
    static func getCoffeShopById(idCoffeShop: String) -> CoffeeShop? {
        return coffeeShops.filter({ (coffeShopItem: CoffeeShop) -> Bool in
            return coffeShopItem.id == idCoffeShop
        }).first
    }
    
    static func getAll(splitedByMinimum distance: Double) -> [String: [CoffeeShop]] {
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
    
    static func setUpLocationNotifications() {
        for coffeeBar in coffeeShops {
            registerProximityNotification(for: coffeeBar)
        }
    }
    
    static func registerProximityNotification(for coffeeBar: CoffeeShop) {
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
