//
//  DetailViewController.swift
//  Homepwner
//
//  Created by chinny ponnoose on 30/08/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberfield: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    //property observers - wiill set - property is about to change
    //didset - when a property did change

    @IBAction func takePicture(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
         if UIImagePickerController.isSourceTypeAvailable(.Camera)
         {
            imagePicker.sourceType = .Camera
         }
         else{
            imagePicker.sourceType = .PhotoLibrary
        }
        //simce delegate propert of imagepicker controller is confirming to navigation controller delegate and image picker controller delegate
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func clearImage(sender: UIBarButtonItem) {
        imageStore.deleteImageForKey(item.itemKey)
        imageView.image = nil
        
    }
    var item :Item!
    {
        didSet{
            navigationItem.title = item.name
        }
    }
    
    var imageStore :ImageStore!
    
  //inline definitions using closures
    let numberFormatter :NSNumberFormatter =
        {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
        }()
    
    let dateFormatter:NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notObserver = NSNotificationCenter.defaultCenter()
        notObserver.addObserver(self, selector: #selector(dateChangedNotification), name: "DateChangeNotification", object: nil)
        
        
    }
    
    func dateChangedNotification(notification:NSNotification) -> Void
    {
        guard let userInfo = notification.userInfo,
              let date = userInfo["date"] as? NSDate else
        {
            return
        }
        item.dateCreated = date
    }
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        nameField.text = item.name
        serialNumberfield.text = item.serialNumber
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        imageView.image = imageStore.imageForKey(item.itemKey)
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        //clear first responder
        view.endEditing(true)
        
        //coalesce nil
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberfield.text ?? ""
        //multiple let statements in if
        if let valueText = valueField.text,
            value = numberFormatter.numberFromString(valueText)
        {
            item.valueInDollars = value.integerValue
        }
        else{
            item.valueInDollars = 0
        }
    }
    
    //Mark: - Textfield Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
  
}
