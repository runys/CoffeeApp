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
        
        self.history = APIManager.shared.getHistory()
        self.history.sort { $0.timestamp > $1.timestamp }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        EventsManager.shared.makeThisObject(self, observeTheEventNamed: "newDrinkEntry", withThisFunction: #selector(reloadData))
    }
    
    @objc func reloadData() {
        self.history = APIManager.shared.getHistory()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Empty State
        if self.history.count == 0 {
            return 1
        }
        
        return self.history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Empty State
        if self.history.count == 0 {
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "emptyStateCell", for: indexPath)
            return cell
        }
        
        // Ideal State
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkHistoryIdentifier", for: indexPath) as! DrinkHistoryTableViewCell
        
        let drinkRecord = self.history[indexPath.row]
        
        let coffeeName = drinkRecord.coffee.name
        let placeName = drinkRecord.place?.name ?? "---"
        
        let when = "\(drinkRecord.date) at \(drinkRecord.time)"
        
        cell.coffeeNameLabel.text = coffeeName
        cell.locationNameLabel.text = placeName
        
        cell.dateAndTimeLabel.text = "\(when)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if self.history.count > 0 {
            if editingStyle == .delete {
                self.history.remove(at: indexPath.row)
                
                // Empty state
                if self.history.count == 0 {
                    self.tableView.reloadData()
                } else {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }

}
