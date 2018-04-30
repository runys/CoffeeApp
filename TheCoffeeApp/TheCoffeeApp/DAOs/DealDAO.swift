//
//  DealDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class DealDAO {
    
    private static var dealsDatabase: [Deal] = {
        var deals = [Deal]()
        
        let coffeShops = CoffeeShopDAO.getAll()
        
        let deal1 = Deal(store: coffeShops[0],
                         coffee: coffeShops[0].coffees[0].coffee,
                         previousPrice: coffeShops[0].coffees[0].price,
                         newPrice: coffeShops[0].coffees[0].price * 0.8)
        deals.append(deal1)
        
        let deal2 = Deal(store: coffeShops[1],
                         coffee: coffeShops[1].coffees[0].coffee,
                         previousPrice: coffeShops[1].coffees[0].price,
                         newPrice: coffeShops[1].coffees[0].price * 0.5)
        deals.append(deal2)
        
        
        return deals
    }()
    
    static func getAllDeals() -> [Deal] {
        return dealsDatabase
    }
    
}
