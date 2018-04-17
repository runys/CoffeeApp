//
//  CoffeeShop.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

struct Location {
    var latitude: Double
    var longitude: Double
}

class CoffeeShop {
    let id: String
    let name: String
    let location: Location
    let imageURL : String
    let description: String
    let coffees: [(name: String, rating: Int, price: Float)]
    
    init(id: String, name: String, location: Location, imageURL: String, description: String) {
        self.id = id
        self.name = name
        self.location = location
        self.imageURL = imageURL
        self.description = description
        
        self.coffees = []
    }
    
    var topThreeCoffees: [(name: String, rating: Int, price: Float)] {
        // TODO: Calculate top coffees and return the top three in order
        return []
    }
    
    var distanceFromYou: Int {
        // TODO: Calculate distance in meters
        return 0
    }
}
