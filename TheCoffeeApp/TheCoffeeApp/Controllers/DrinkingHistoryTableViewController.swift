//
//  DrinkingHistoryTableViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class DrinkingHistoryTableViewController: UITableViewController {

    var history: [DrinkRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.history = DrinkHistoryDAO.getHistory()
        self.history.sort { $0.timestamp > $1.timestamp }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkHistoryIdentifier", for: indexPath)
        
        let drinkRecord = self.history[indexPath.row]
        
        let coffeeName = drinkRecord.coffee.name
        let placeName = drinkRecord.place.name
        
        let when = "on \(drinkRecord.date), at \(drinkRecord.time)"
        
        // Coffe name
        cell.textLabel?.text = coffeeName
        // Time and place
        cell.detailTextLabel?.text = "\(when) at \(placeName)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
