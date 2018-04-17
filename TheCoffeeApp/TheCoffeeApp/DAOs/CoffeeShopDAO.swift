//
//  CoffeeShopDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

fileprivate var MINIMUN_NEARBY_DISTANCE = 300

class CoffeeShopDAO {
    
    private static var coffeeShops: [CoffeeShop] = [
        CoffeeShop(id: "001",
                   name: "University Bar",
                   location: Location(latitude: 0, longitude: 0),
                   imageURL: "coffee_shop_placeholder",
                   description: "That's a very good coffe bar nearby the Academy. Nunzia is a sweetheart."),
        CoffeeShop(id: "002",
                   name: "Coffee Bar",
                   location: Location(latitude: 0, longitude: 0),
                   imageURL: "coffee_shop_placeholder",
                   description: "A random placeholder coffee bar to increase the amount of entries in the database.")
    ]
    
    static func getAll() -> [CoffeeShop] {
        return coffeeShops
    }
    
    // TODO: Split the dictionary in two keys
    static func getAll(splitedByMinimum distance: Double) -> [String: [CoffeeShop]] {
        return [ "NEARBY" : [], "OTHERS" : []]
    }
    
}
