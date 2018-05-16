//
//  CardView.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 23/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class CardView: UIView {

    override func awakeFromNib() {
        // Background color
        self.backgroundColor = .white
        
        // Rounded corners
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        // Adding drop shadow
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

}
