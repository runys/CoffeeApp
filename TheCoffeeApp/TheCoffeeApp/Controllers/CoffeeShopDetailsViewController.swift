//
//  CoffeeShopDetailsViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CoffeeShopDetailsViewController: UIViewController {

    var coffeeShop: CoffeeShop?
    
    @IBOutlet weak var coffeeShopImageView: UIImageView!
    @IBOutlet weak var coffeeShopMap: MKMapView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var firstCoffeName: UILabel!
    @IBOutlet weak var firstCoffeeRating: UILabel!
    
    @IBOutlet weak var secondCoffeeName: UILabel!
    @IBOutlet weak var secondCoffeeRating: UILabel!
    
    @IBOutlet weak var thirdCoffeeName: UILabel!
    @IBOutlet weak var thirdCoffeeRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Initialize outlets info
        if let coffeeShop = self.coffeeShop {
            self.title = coffeeShop.name
            
            self.descriptionLabel.text = coffeeShop.description
            // TODO: Really download the image
            self.coffeeShopImageView.image = UIImage(named: coffeeShop.imageURL)
            
            // TODO: Set up the coffee ranking
        } else {
            self.title = "Coffee Shop"
        }
    }
    
    func setUpMap() {
        
    }

}
