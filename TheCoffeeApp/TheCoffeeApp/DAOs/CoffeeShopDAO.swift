//
//  CoffeeShopDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation


class CoffeeShopDAO {
    

    
//    static func getCoffeShopById(idCoffeShop: String) -> CoffeeShop? {
//        return coffeeShops.filter({ (coffeShopItem: CoffeeShop) -> Bool in
//            return coffeShopItem.id == idCoffeShop
//        }).first
//    }
    
//    static func getAll(splitedByMinimum distance: Double) -> [String: [CoffeeShop]] {
//        var coffeeBars: [String: [CoffeeShop]] = ["NEARBY" : [], "OTHERS" : []]
//        
//        for coffeeBar in coffeeShops {
//            if coffeeBar.distanceFromYou < MINIMUN_NEARBY_DISTANCE {
//                coffeeBars["NEARBY"]?.append(coffeeBar)
//            } else {
//                coffeeBars["OTHERS"]?.append(coffeeBar)
//            }
//        }
//        
//        return coffeeBars
//    }
//    
//    static func setUpLocationNotifications() {
//        for coffeeBar in coffeeShops {
//            registerProximityNotification(for: coffeeBar)
//        }
//    }
//    
//    static func registerProximityNotification(for coffeeBar: CoffeeShop) {
//        let locationIdentifier = coffeeBar.locationIdentifier
//        let requestIdentifier = "ProximityNotificationTo\(coffeeBar.name)"
//        
//        let notificationSettings: ProximityNotificationContent
//            = ProximityNotificationContent(title: "A coffee bar is near!",
//                                           bodyText: "Why don't you stop by \(coffeeBar.name) and drink a \(coffeeBar.topThreeCoffees[0].name)?",
//                                           latitude: coffeeBar.location.latitude,
//                                           longitude: coffeeBar.location.longitude,
//                                           radiusInMeters: 100,
//                                           locationIdentifier: locationIdentifier,
//                                           requestUniqueIdentifier: requestIdentifier,
//                                           info: ["coffeeBarName": coffeeBar.name, "coffeeBarID": coffeeBar.id])
//        
//        NotificationCenterManager.shared
//            .registerProximityNotification(notificationContent: notificationSettings)
//    }
}
