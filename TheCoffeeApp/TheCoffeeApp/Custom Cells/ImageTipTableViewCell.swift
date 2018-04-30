//
//  ImageTipTableViewCell.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 23/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class ImageTipTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tipImageView: UIImageView!
    @IBOutlet weak var blackoutView: UIView!
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tipImageView.layer.cornerRadius = 10
        self.tipImageView.clipsToBounds = true
        
        self.blackoutView.layer.cornerRadius = 10
        self.blackoutView.clipsToBounds = true
    }
}
