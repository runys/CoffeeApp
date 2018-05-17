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
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkHistoryIdentifier", for: indexPath) as! DrinkHistoryTableViewCell
        
        let drinkRecord = self.history[indexPath.row]
        
        let coffeeName = drinkRecord.coffee.name
        let placeName = drinkRecord.place.name
        
        let when = "\(drinkRecord.date) at \(drinkRecord.time)"
        
        cell.coffeeNameLabel.text = coffeeName
        cell.locationNameLabel.text = placeName
        
        cell.dateAndTimeLabel.text = "\(when)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.history.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
