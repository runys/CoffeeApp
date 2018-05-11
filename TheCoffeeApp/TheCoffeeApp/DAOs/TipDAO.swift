//
//  TipDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class TipDAO {

    private static var tipsDatabase: [Tip] = [
        Tip(subject: "Using a Moca", headline: "A mountain is important", description: "When you fill the moka, remember to make a little mountain."),
        Tip(subject: "What is it?", headline: "This is a Moka", imageURL: "moka"),
        Tip(subject: "Water for coffee", headline: "The water makes the difference", description: "The water makes the difference. Always use water from Naples. It has vulcanic properties which will turn your skin into silk.")
    ]
    
    static func getAllTips() -> [Tip] {
        return tipsDatabase
    }
    
    static func addTip(tip: Tip) {
        tipsDatabase.append(tip)
    }
    
    static func makeTip(_ notificationDictionary: [String: AnyObject]) -> Tip? {
        if let subject = notificationDictionary["subject"] as? String,
            let headline = notificationDictionary["headline"] as? String,
            let description = notificationDictionary["description"] as? String{
            let tip = Tip(subject: subject, headline: headline, description: description)
            addTip(tip: tip)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshTips"), object: self)
            return tip
            
        }
        return nil
    }
}
