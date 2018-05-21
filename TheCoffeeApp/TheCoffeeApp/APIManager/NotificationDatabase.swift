//
//  NotificationDatabase.swift
//  TheCoffeeApp
//
//  Created by Massimiliano Di Mella on 18/05/18.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

// - MARK: Coffee

let espresso = Coffee(id: "001", name: "Espresso", imageURL: "coffee-espresso")
let doubleEspresso = Coffee(id: "002", name: "Double Espresso", imageURL: "coffee-espresso-doppio")
let ristretto = Coffee(id: "003", name: "Ristretto", imageURL: "coffee-ristretto")
let cappuccino = Coffee(id: "004", name: "Cappuccino", imageURL: "coffee-cappuccino")
let americano = Coffee(id: "005", name: "Americano", imageURL: "coffee-americano")
let latte = Coffee(id: "006", name: "Latte", imageURL: "coffee-latte")
let macchiato = Coffee(id: "007", name: "Macchiato", imageURL: "coffee-macchiato")
let mocha = Coffee(id: "008", name: "Mocha", imageURL: "coffee-mocha")
let caffeNocciola = Coffee(id: "009", name: "Caffe Nocciola", imageURL: "coffee-nocciola")
let cioccolattaCalda = Coffee(id: "010", name: "Cioccolatta Calda", imageURL: "coffee-cioccolatta-calda")


// - MARK:  Coffee Shop
let universityBar = CoffeeShop(id: "001",
                               name: "University Bar",
                               location: Location(latitude: 40.8362063, longitude: 14.3061987),
                               imageURL: "coffeebar-placeholder-1",
                               description: "That's a very good coffe bar nearby the Academy. Nunzia is a sweetheart.",
                               coffees: [
                                (coffee: espresso, rating: 1, price: 0.9),
                                (coffee: macchiato, rating: 2, price: 0.9),
                                (coffee: cappuccino, rating: 3, price: 1.5)]
)

let barLorenzo = CoffeeShop(id: "002",
                            name: "Bar Lorenzo",
                            location: Location(latitude: 40.8354467, longitude: 14.3042449),
                            imageURL: "coffeebar-placeholder-2",
                            description: "A random placeholder coffee bar to increase the amount of entries in the database.",
                            coffees: [
                                (coffee: espresso, rating: 3, price: 0.9),
                                (coffee: macchiato, rating: 2, price: 0.9),
                                (coffee: doubleEspresso, rating: 1, price: 1.5)]
)

let barMexico = CoffeeShop(id: "003",
                           name: "Mexico",
                           location: Location(latitude: 40.8462759, longitude: 14.2515021),
                           imageURL: "coffeebar-placeholder-3",
                           description: "That's a random coffe bar added for testing purposes. Enjoy the randomness.",
                           coffees: [
                            (coffee: americano, rating: 2, price: 0.9),
                            (coffee: latte, rating: 1, price: 1.9)]
)

let barProfessore = CoffeeShop(id: "004",
                               name: "Il Vero Bar del Professore",
                               location: Location(latitude: 40.8462759, longitude: 14.2515021),
                               imageURL: "coffeebar-placeholder-4",
                               description: "A well known coffee bar in the city of Napoli. Home of the famous Cafè Nocciola.",
                               coffees: [
                                (coffee: espresso, rating: 2, price: 0.9),
                                (coffee: caffeNocciola, rating: 1, price: 1.5),
                                (coffee: mocha, rating: 4, price: 1.0),
                                (coffee: macchiato, rating: 3, price: 0.9)]
)

let caffeGambrinus = CoffeeShop(id: "005",
                                name: "Gran Caffè Gambrinus",
                                location: Location(latitude: 40.8462759, longitude: 14.2515021),
                                imageURL: "coffeebar-placeholder-5",
                                description: "",
                                coffees: [
                                    (coffee: macchiato, rating: 3, price: 1.5),
                                    (coffee: caffeNocciola, rating: 1, price: 1.5),
                                    (coffee: espresso, rating: 3, price: 1.5)]
)

// - MARK: Tip

let tip1 = Tip(subject: "Using a Moca", headline: "A mountain is important", description: "When you fill the moka, remember to make a little mountain.")
let tip2 = Tip(subject: "What is it?", headline: "This is a Moka", imageURL: "moka")
let tip3 = Tip(subject: "Water for coffee", headline: "The water makes the difference", description: "The water makes the difference. Always use water from Naples. It has vulcanic properties which will turn your skin into silk.")

// - MARK: Deal

let deal1 = Deal(store: universityBar,
                 coffee: universityBar.coffees[0].coffee,
                 previousPrice: universityBar.coffees[0].price,
                 newPrice: universityBar.coffees[0].price * 0.5)

let deal2 = Deal(store: barLorenzo,
                 coffee: barLorenzo.coffees[1].coffee,
                 previousPrice: barLorenzo.coffees[1].price,
                 newPrice: barLorenzo.coffees[1].price * 0.9)

let deal3 = Deal(store: barMexico,
                 coffee: barMexico.coffees[1].coffee,
                 previousPrice: barMexico.coffees[1].price,
                 newPrice: barMexico.coffees[1].price * 0.5)

let deal4 = Deal(store: barProfessore,
                 coffee: barProfessore.coffees[1].coffee,
                 previousPrice: barProfessore.coffees[1].price,
                 newPrice: barProfessore.coffees[1].price * 0.75)

// - MARK: DrinkHistory

let record1 = DrinkRecord(didDrink: true,
                          coffee: universityBar.coffees[0].coffee,
                          timestamp: Date().addingTimeInterval(TimeInterval(3600)),
                          place: universityBar)
let record2 = DrinkRecord(didDrink: true,
                          coffee: universityBar.coffees[0].coffee,
                          timestamp: Date().addingTimeInterval(TimeInterval(4800)),
                          place: barLorenzo)
let record3 = DrinkRecord(didDrink: true,
                          coffee: universityBar.coffees[0].coffee,
                          timestamp: Date(),
                          place: universityBar)
let record4 = DrinkRecord(didDrink: true,
                          coffee: universityBar.coffees[1].coffee,
                          timestamp: Date().addingTimeInterval(TimeInterval(12000)),
                          place: universityBar)
