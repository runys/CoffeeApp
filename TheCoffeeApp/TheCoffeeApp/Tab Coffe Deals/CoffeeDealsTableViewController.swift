//
//  CoffeeDealsTableViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class CoffeeDealsTableViewController: UITableViewController {
    

    var coffeeDeals: [Deal] = []
    

 @objc func refreshData(){
//
        DispatchQueue.main.async {
            self.coffeeDeals = APIManager.shared.getAllDeals()
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.coffeeDeals.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
    }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coffeeDeals = APIManager.shared.getAllDeals()
        self.tableView.estimatedRowHeight = 166
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(CoffeeDealsTableViewController.refreshData), name: NSNotification.Name(rawValue: "refreshDeals"), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeDeals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeDealIdentifier", for: indexPath)
        
        if let dealCell = cell as? CoffeeDealTableViewCell {
            let deal = self.coffeeDeals[indexPath.row]
            
            dealCell.storeNameLabel.text = deal.store.name
            dealCell.coffeeNameLabel.text = deal.coffee.name
            
            dealCell.newPriceLabel.text = String(format: "%.2f€", deal.discountedPrice)
            dealCell.oldPriceLabel.text = String(format: "%.2f€", deal.previousPrice)
            
            dealCell.coffeeImageView.image = UIImage(named: deal.coffee.imageURL)
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
}
