//
//  Tip.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

enum TipType: String {
    case image = "IMAGE"
    case text = "TEXT"
}

class Tip {
    let type: TipType
    let subject: String
    let headline: String
    var description: String? = nil
    var imageURL: String? = nil
    
    init(subject: String, headline: String, imageURL: String) {
        self.type = .image
        
        self.subject = subject
        self.headline = headline
        self.imageURL = imageURL
    }
    
    init(subject: String, headline: String, description: String) {
        self.type = .text
        
        self.subject = subject
        self.headline = headline
        self.description = description
    }
}
