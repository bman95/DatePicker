//
//  EventDetailViewController.swift
//  DatePicker
//
//  Created by Brendon Crowe on 12/19/22.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    var event: Event?
    
    // lazy variable - a variable that gets created the first time its needed, not when the view comes on screen
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyy h:mm a"
        return formatter
    }() // () calls the function (closure)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    // method used to update the UI elements
    func updateUI() {
        guard let date = event?.date else { return }
        selectedDateLabel.text = dateFormatter.string(from: date)
        
        
        // set switch position based on value of willAttend, true or false
        switchControl.isOn = event?.willAttend ?? false
        eventName.text = event?.name ?? "Event name not available"
    }
    
    
    @IBAction func rsvpChanged(_ sender: UISwitch) {
        event?.willAttend = sender.isOn
    }
}
