//
//  LocationServices.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 18/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    var latitude: Double
    var longitude: Double
}

class LocationServices {
    
    // Singleton imnplementation
    private static let instance = LocationServices()
    
    static var shared: LocationServices {
        return LocationServices.instance
    }
    
    // Location manager implementation
    private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    func requestAuthorization() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //
    var userCLLocation: CLLocation {
        self.requestAuthorization()
        
        return self.locationManager.location ?? CLLocation(latitude: 0, longitude: 0)
    }
    
    var userLocation: Location {
        return Location(latitude: self.userCLLocation.coordinate.latitude, longitude: self.userCLLocation.coordinate.longitude)
    }
    
    // Calculate distance between two location in meters
    func distance(from locationA: Location, to locationB: Location) -> Double {
        let departure: CLLocation = CLLocation(latitude: locationA.latitude, longitude: locationA.longitude)
        let destination: CLLocation = CLLocation(latitude: locationB.latitude, longitude: locationB.longitude)
        
        print(departure.distance(from: destination))
        
        return 0.0
    }
    
    // Calculate distance between the user postion and a location, in meters
    func distance(to location: Location) -> Double {
        let destination: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        let calculatedDistance = self.userCLLocation.distance(from: destination)
        return calculatedDistance
    }
    
}
