//
//  ViewController.swift
//  DatePicker
//
//  Created by Brendon Crowe on 12/19/22.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var rsvpLabel: UILabel!
    
    var event: Event! {
        didSet {
            // update ui whenever event is changed
            if event.willAttend {
                rsvpLabel.text = "RSVP YES"
                createEventButton.setTitle("View Event", for: .normal)
            } else {
                rsvpLabel.text = "RSVP NO"
                createEventButton.setTitle("RSVP to Event", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTextField.delegate = self
        event = Event(name: "Upcoming Event", date: Date(), willAttend: false)
        // Date() initializes the current day's date
        
        // configure date picker in code
        datePicker.minimumDate = Date() // this means the user cannot set a date prior to current day's date
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let eventDetailVC = segue.destination as? EventDetailViewController else { return }
        eventDetailVC.event = event
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        event.date = sender.date
    }
    
    @IBAction func createEventButtonTapped(_ sender: UIButton) {
        event.name = eventTextField.text ?? ""
    }
    
    // unwind segue action
    // need to create an IBAction for the unwind segue
    // it's required to have a parameter of type UIStoryboardSegue in the unwind segue action as it is the only way IB can recognize an unwind segue to connect to
    // what differs from prepare for segue is segue.source
    @IBAction func updateUIFromUnwindSegue(segue: UIStoryboardSegue) {
        guard let eventDetailViewController = segue.source as? EventDetailViewController else { return }
        event = eventDetailViewController.event
    }
}

extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
