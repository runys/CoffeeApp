//
//  DrinkRecord.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class DrinkRecord {
    let didDrink: Bool
    let timestamp: Date
    let place: CoffeeShop
    let coffee: Coffee
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM"
        
        return dateFormatter.string(from: self.timestamp)
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self.timestamp)
    }
    
    init(didDrink: Bool, coffee: Coffee, timestamp: Date, place: CoffeeShop) {
        self.didDrink = didDrink
        self.timestamp = timestamp
        self.place = place
        self.coffee = coffee
    }
}
