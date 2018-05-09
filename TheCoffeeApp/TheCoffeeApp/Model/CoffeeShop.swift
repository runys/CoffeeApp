//
//  CoffeeShop.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

typealias CoffeeListEntry = (coffee: Coffee, rating: Int, price: Float)

class CoffeeShop{
    
    let id: String
    let name: String
    let location: Location
    let imageURL : String
    let description: String
    let coffees: [CoffeeListEntry]
    
    init(id: String, name: String, location: Location, imageURL: String, description: String) {
        self.id = id
        self.name = name
        self.location = location
        self.imageURL = imageURL
        self.description = description
        
        self.coffees = []
    }
    
    init(id: String, name: String, location: Location, imageURL: String, description: String, coffees: [CoffeeListEntry]) {
        self.id = id
        self.name = name
        self.location = location
        self.imageURL = imageURL
        self.description = description
        
        self.coffees = coffees
    }
    
    var topThreeCoffees: [Coffee] {
        
        let sortedCoffees = self.coffees.sorted { $0.rating > $1.rating }
        
        var topThreeCoffees = [Coffee]()
        
        for coffeeEntry in sortedCoffees {
            if topThreeCoffees.count < 3 {
                topThreeCoffees.append(coffeeEntry.coffee)
            }
        }
        
        return topThreeCoffees
    }
    
    var distanceFromYou: Double {
        let kmDistance = LocationServices.shared.distance(to: self.location) / 1000
        return kmDistance
    }
}
