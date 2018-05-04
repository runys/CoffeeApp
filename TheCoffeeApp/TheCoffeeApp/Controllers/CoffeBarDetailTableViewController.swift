//
//  CoffeBarDetailTableViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 02/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit
import MapKit

class CoffeBarDetailTableViewController: UITableViewController {
    
    private let cornerRadius: CGFloat = 5.0
    
    var coffeeBar: CoffeeShop?
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var locationMapView: MKMapView!
    
    @IBOutlet weak var firstCoffeeImageView: UIImageView!
    @IBOutlet weak var secondCoffeeImageView: UIImageView!
    @IBOutlet weak var thirdCoffeeImageView: UIImageView!
    @IBOutlet weak var forthCoffeeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpInterface()
        
        if let coffeeBar = self.coffeeBar {
            self.setUpInformation(coffeeBar)
        }
    }

    func setUpInterface() {
        self.locationMapView.layer.cornerRadius = cornerRadius
        self.locationMapView.clipsToBounds = true
        
        self.firstCoffeeImageView.layer.cornerRadius = cornerRadius
        self.firstCoffeeImageView.clipsToBounds = true
        self.secondCoffeeImageView.layer.cornerRadius = cornerRadius
        self.secondCoffeeImageView.clipsToBounds = true
        self.thirdCoffeeImageView.layer.cornerRadius = cornerRadius
        self.thirdCoffeeImageView.clipsToBounds = true
        self.forthCoffeeImageView.layer.cornerRadius = cornerRadius
        self.forthCoffeeImageView.clipsToBounds = true
    }
    
    func setUpInformation(_ coffeeBar: CoffeeShop) {
        self.headerImageView.image = UIImage(named: coffeeBar.imageURL)
        self.nameLabel.text = coffeeBar.name
        self.descriptionLabel.text = coffeeBar.description
        
        self.setUpCoffeeImages(coffeeBar)
        self.setupLocation(coffeeBar)
    }
    
    func setupLocation(_ coffeeBar: CoffeeShop) {
        // TODO: Set up the coffee bar location in the map
    }
    
    func setUpCoffeeImages(_ coffeeBar: CoffeeShop) {
        let coffees = coffeeBar.coffees.map { $0.coffee }
        
        for (index, coffee) in coffees.enumerated() {
            switch index {
            case 0:
                self.firstCoffeeImageView.image = UIImage(named: coffee.imageURL)
            case 1:
                self.secondCoffeeImageView.image = UIImage(named: coffee.imageURL)
            case 2:
                self.thirdCoffeeImageView.image = UIImage(named: coffee.imageURL)
            case 3:
                self.forthCoffeeImageView.image = UIImage(named: coffee.imageURL)
            default:
                break
            }
        }
        
    }
}









