//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by chinny ponnoose on 30/08/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet var selectedDate: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    let formatter:NSDateFormatter = {
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = .MediumStyle
        dateformatter.timeStyle = .MediumStyle
        return dateformatter
    }()

    
    @IBAction func dateChanged(sender: AnyObject) {
        
       // let dateformatter = NSDateFormatter()
        //dateformatter.dateStyle = .MediumStyle
       // dateformatter.timeStyle = .NoStyle
        let dateStr = formatter.stringFromDate(datePicker.date)
        self.selectedDate.text = dateStr
        let dateChangeNotification = NSNotificationCenter.defaultCenter()
        dateChangeNotification .postNotificationName("DateChangeNotification", object: self, userInfo: ["date":datePicker.date])
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let dateStr = formatter.stringFromDate(datePicker.date)
        self.selectedDate.text = dateStr
       
    }
}
