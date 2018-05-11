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
                         newPrice: coffeShops[0].coffees[0].price * 0.5)
        deals.append(deal1)
        
        let deal2 = Deal(store: coffeShops[1],
                         coffee: coffeShops[1].coffees[1].coffee,
                         previousPrice: coffeShops[1].coffees[1].price,
                         newPrice: coffeShops[1].coffees[1].price * 0.9)
        deals.append(deal2)
        
        let deal3 = Deal(store: coffeShops[2],
                         coffee: coffeShops[2].coffees[1].coffee,
                         previousPrice: coffeShops[2].coffees[1].price,
                         newPrice: coffeShops[2].coffees[1].price * 0.5)
        deals.append(deal3)
        
        let deal4 = Deal(store: coffeShops[3],
                         coffee: coffeShops[3].coffees[1].coffee,
                         previousPrice: coffeShops[3].coffees[1].price,
                         newPrice: coffeShops[3].coffees[1].price * 0.75)
        deals.append(deal4)
        
        return deals
    }()
    
    static func getAllDeals() -> [Deal] {
        return dealsDatabase
    }
    
    static func addDeal(deal: Deal) {
        dealsDatabase.append(deal)
    }
    
    
    static func makeDeal(_ notificationDictionary: [String: AnyObject]) -> Deal? {
        if let coffeeShopId = notificationDictionary["coffeShopId"] as? String,
           let coffeShop = CoffeeShopDAO.getCoffeShopById(idCoffeShop: coffeeShopId){
            let deal = Deal(store: coffeShop,
                            coffee: coffeShop.coffees[0].coffee,
                            previousPrice: coffeShop.coffees[0].price,
                            newPrice: coffeShop.coffees[0].price * 0.8)
            addDeal(deal: deal)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshDeals"), object: self)
            return deal
           
        }
        return nil
    }
    
    
}
