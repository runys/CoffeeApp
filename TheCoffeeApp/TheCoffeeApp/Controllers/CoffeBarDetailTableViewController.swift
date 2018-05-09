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
    private let mapSpan: MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
    private let cornerRadius: CGFloat = 5.0
    
    var coffeeBar: CoffeeShop?
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var locationMapView: MKMapView!
    
    @IBOutlet weak var firstCoffeeImageView: UIImageView!
    @IBOutlet weak var firstCoffeeLabel: UILabel!
    
    @IBOutlet weak var secondCoffeeImageView: UIImageView!
    @IBOutlet weak var secondCoffeeLabel: UILabel!
    
    @IBOutlet weak var thirdCoffeeImageView: UIImageView!
    @IBOutlet weak var thirdCoffeeLabel: UILabel!
    
    @IBOutlet weak var forthCoffeeImageView: UIImageView!
    @IBOutlet weak var forthCoffeeLabel: UILabel!
    
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpInterface()
        
        if let coffeeBar = self.coffeeBar {
            self.setUpInformation(coffeeBar)
        }
    }

    func setUpInterface() {
        
        self.closeButton.layer.cornerRadius = cornerRadius
        self.closeButton.clipsToBounds = true
        
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
        self.locationMapView.showsUserLocation = true
        
        let coffeeBarAnnotation: MKPointAnnotation = MKPointAnnotation()
        
        let coffeBarLocation = CLLocationCoordinate2D(latitude: coffeeBar.location.latitude, longitude: coffeeBar.location.longitude)
        
        coffeeBarAnnotation.coordinate = coffeBarLocation
        
        self.locationMapView.addAnnotation(coffeeBarAnnotation)
        
        self.locationMapView.region = MKCoordinateRegion(center: coffeBarLocation, span: self.mapSpan)
    }
    
    func setUpCoffeeImages(_ coffeeBar: CoffeeShop) {
        let coffees = coffeeBar.coffees.map { $0.coffee }
        
        for (index, coffee) in coffees.enumerated() {
            switch index {
            case 0:
                self.firstCoffeeImageView.image = UIImage(named: coffee.imageURL)
                self.firstCoffeeLabel.text = coffee.name
            case 1:
                self.secondCoffeeImageView.image = UIImage(named: coffee.imageURL)
                self.secondCoffeeLabel.text = coffee.name
            case 2:
                self.thirdCoffeeImageView.image = UIImage(named: coffee.imageURL)
                self.thirdCoffeeLabel.text = coffee.name
            case 3:
                self.forthCoffeeImageView.image = UIImage(named: coffee.imageURL)
                self.forthCoffeeLabel.text = coffee.name
            default:
                break
            }
        }
        
    }
}









