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
        CoffeeRemindersDAO.getAllReminders { (coffeeReminders) in
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
        return self.reminders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkReminderIdentifier", for: indexPath)

        let reminder = self.reminders[indexPath.row]
        let coffee = CoffeeDAO.getCoffee(reminder.coffeeID)!
        
        cell.imageView?.image = UIImage(named: coffee.imageURL)
        cell.imageView?.layer.cornerRadius = 5
        cell.imageView?.clipsToBounds = true
        
        cell.textLabel?.text = String(format: "%@ at %02d:%02d", reminder.coffeeName, reminder.hour, reminder.minutes)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let reminderToDelete = self.reminders[indexPath.row]
            
            CoffeeRemindersDAO.deleteReminder(reminderToDelete)
            self.reminders.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func cancel(withSegue: UIStoryboardSegue) {
        print("Reminders creation canceled.")
    }
    
    @IBAction func reminderCreated(withSegue: UIStoryboardSegue) {
        print("Reminders created.")
        
        self.getReminders()
    }
    

}
