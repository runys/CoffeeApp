//
//  CoffeeDealTableViewCell.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 30/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class CoffeeDealTableViewCell: UITableViewCell {
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var blackoutView: UIView!
    
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    
    @IBOutlet weak var coffeeNameLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.blackoutView.layer.cornerRadius = 10
        self.blackoutView.clipsToBounds = true
        
        self.coffeeImageView.layer.cornerRadius = 10
        self.coffeeImageView.clipsToBounds = true
    }
}
