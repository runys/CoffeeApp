//
//  CoffeeRemindersTableViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class CoffeeRemindersTableViewController: UITableViewController {
    
    var reminders: [CoffeeReminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getReminders()
    }
    
    func getReminders() {
        APIManager.shared.getAllReminders { (coffeeReminders) in
            self.reminders = coffeeReminders
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Empty State
        if self.reminders.count == 0 {
            return 1
        }
        // Ideal State
        return self.reminders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Empty State
        if self.reminders.count == 0 {
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "emptyStateCell", for: indexPath)
            return cell
        }
        
        // Ideal State
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkReminderIdentifier", for: indexPath)

        let reminder = self.reminders[indexPath.row]
        let coffee = APIManager.shared.getCoffee(reminder.coffeeID)!
        
        cell.imageView?.image = UIImage(named: coffee.imageURL)
        cell.imageView?.layer.cornerRadius = 5
        cell.imageView?.clipsToBounds = true
        
        cell.textLabel?.text = String(format: "%@ at %02d:%02d", reminder.coffeeName, reminder.hour, reminder.minutes)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if self.reminders.count > 0 {
            if editingStyle == .delete {
                // Delete the row from the data source
                let reminderToDelete = self.reminders[indexPath.row]
                
                APIManager.shared.deleteReminder(reminderToDelete)
                self.reminders.remove(at: indexPath.row)
                
                // Empty State
                if self.reminders.count == 0 {
                    self.tableView.reloadData()
                } else {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func cancel(withSegue: UIStoryboardSegue) {
        print("Reminders creation canceled.")
    }
    
    @IBAction func reminderCreated(withSegue: UIStoryboardSegue) {
        print("Reminders created.")
        
        self.getReminders()
    }
    

}
