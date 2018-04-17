//
//  NearbyCoffeShopsTableViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

// TODO: Explain
fileprivate let NEARBY: String = "NEARBY"
fileprivate let OTHERS: String = "OTHERS"

class NearbyCoffeShopsTableViewController: UITableViewController {

    // TODO: Explain
    var coffeeShops: [String: [CoffeeShop]] = [
        NEARBY: [],
        OTHERS: []
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Get the information from the DAO to populate the local array
    }

    // MARK: - Table view data source

    // TODO: Explain
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1.
        return self.coffeeShops.count
    }

    // TODO: Explain
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1.
        var rowsArray: [CoffeeShop]
        
        // 2.
        switch section {
        case 0:
            rowsArray = self.coffeeShops[NEARBY] ?? []
        case 1:
            rowsArray = self.coffeeShops[OTHERS] ?? []
        default:
            rowsArray = []
        }
        // 3.
        return rowsArray.count
    }

    // TODO: Explain
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeShopIdentifier", for: indexPath)
        // TODO: Configure cells per section
        return cell
    }
    
    // TODO: Explain
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Nearby coffee shops"
        case 1:
            return "Other coffee shops"
        default:
            return nil
        }
    }

    // MARK: - Navigation
    
    // TODO: Explain
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Navigation to coffee shop details
        // TODO: Add segue identifier
    }


}
