//
//  NewReminderViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 14/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

class NewReminderViewController: UIViewController {

    @IBOutlet weak var timeDatePicker: UIDatePicker!
    
    @IBOutlet weak var coffeePickerView: UIPickerView!
    
    private var coffees: [Coffee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coffeePickerView.dataSource = self
        self.coffeePickerView.delegate = self
        
        self.coffees = APIManager.shared.getAllCoffees()
    }
    
    var selectedHour: Int {
        let selectedDate = timeDatePicker.date
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: selectedDate)
        
        return hour
    }
    
    var selectedMinute: Int {
        let selectedDate = timeDatePicker.date
        let calendar = Calendar.current
        
        let minute = calendar.component(.minute, from: selectedDate)
        
        return minute
    }
    
    var selectedCoffee: Coffee {
        let selectedRow = self.coffeePickerView.selectedRow(inComponent: 0)
        let coffeeID = self.coffees[selectedRow].id
        
        return APIManager.shared.getCoffee(coffeeID)!
    }
    
    @IBAction func createCoffeeReminder(_ sender: Any) {
        APIManager.shared.createReminder(hour: selectedHour, minute: selectedMinute, coffeeID: selectedCoffee.id)
        
        self.performSegue(withIdentifier: "doneSegueIdentifier", sender: nil)
        
    }
}

extension NewReminderViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coffees.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coffees[row].name
    }
    
    
}
