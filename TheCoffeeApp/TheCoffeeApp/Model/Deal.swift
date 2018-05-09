//
//  Deal.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class Deal{

    
    
    let store: CoffeeShop
    let coffee: Coffee
    let previousPrice: Float
    let discountedPrice: Float
    
    init(store: CoffeeShop, coffee: Coffee, previousPrice: Float, newPrice: Float) {
        self.store = store
        self.coffee = coffee
        self.previousPrice = previousPrice
        self.discountedPrice = newPrice
    }
}
