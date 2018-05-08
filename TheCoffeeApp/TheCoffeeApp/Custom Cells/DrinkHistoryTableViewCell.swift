//
//  DrinkHistoryTableViewCell.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 08/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class DrinkHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var coffeeNameLabel: UILabel!
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColorView.layer.cornerRadius = 5
        self.backgroundColorView.clipsToBounds = true
    }

}
