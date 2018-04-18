//
//  CoffeeDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class CoffeeDAO {
    
    // Temporary database of coffees
    // Examples from: http://www.latteartguide.com/2016/01/different-types-of-coffee.html
    private static var coffeeDatabase: [Coffee] = [
        Coffee(id: "001", name: "Espresso", imageURL: "coffee_square_1"),
        Coffee(id: "002", name: "Double Espresso", imageURL: "coffee_square_1"),
        Coffee(id: "003", name: "Ristretto", imageURL: "coffee_square_1"),
        Coffee(id: "004", name: "Cappuccino", imageURL: "coffee_square_1"),
        Coffee(id: "005", name: "Americano", imageURL: "coffee_square_1"),
        Coffee(id: "006", name: "Latte", imageURL: "coffee_square_1"),
        Coffee(id: "007", name: "Macchiato", imageURL: "coffee_square_1"),
        Coffee(id: "008", name: "Mocha", imageURL: "coffee_square_1")
    ]
    
    static func getAllCoffees() -> [Coffee] {
        return coffeeDatabase
    }
    
    static func getCoffee(_ id: String) -> Coffee? {
        let coffee = coffeeDatabase.first { (coffee) -> Bool in
            return coffee.id == id
        }
        
        return coffee
    }
    
}
