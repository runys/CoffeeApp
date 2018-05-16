//
//  EventManager.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 14/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

class EventsManager {
    
    public static let shared: EventsManager = EventsManager()
    
    // 1.
    func makeThisObject(_ observer: Any,observeTheEventNamed eventName: String, withThisFunction selector: Selector) {
        
        NotificationCenter.default
            .addObserver(observer,
                         selector: selector,
                         name: NSNotification.Name(rawValue: eventName),
                         object: nil)
        
    }
    
    // 2.
    func postEvent(_ eventName: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: eventName), object: nil)
    }
    
}
