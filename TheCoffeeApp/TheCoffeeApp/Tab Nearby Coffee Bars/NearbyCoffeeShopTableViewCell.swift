//
//  NearbyCoffeeShopTableViewCell.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class NearbyCoffeeShopTableViewCell: UITableViewCell {

    @IBOutlet weak var coffeeShopImageView: UIImageView!
    @IBOutlet weak var blackoutView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topCoffeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.coffeeShopImageView.layer.cornerRadius = 10
        self.coffeeShopImageView.clipsToBounds = true
        
        self.blackoutView.layer.cornerRadius = 10
        self.blackoutView.clipsToBounds = true
    }
}
