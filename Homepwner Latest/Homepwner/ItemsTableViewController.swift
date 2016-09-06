//
//  ItemsTableViewController.swift
//  Homepwner
//
//  Created by chinny ponnoose on 26/08/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var itemStore:ItemStore!
    var imageStore:ImageStore!

    //Dependency inversion principle
    
    @IBAction func addNewItem(sender:AnyObject)
    {
   
        let newItem = itemStore.createItem(NSDate())
        let index = itemStore.allItems.indexOf(newItem)
        let indexpath = NSIndexPath(forRow: index!, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexpath], withRowAnimation: .Automatic)
        
    }
    
    //viewcontroller itself is giving the edit bar buttton that will automically set toggle mode
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem"
        {
            if let row = tableView.indexPathForSelectedRow?.row
            {

                let item = itemStore.allItems[row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore

            }
        }
    }
    
    //in order to overide pushing for a particular row
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        var val :Bool = false
        if identifier == "ShowItem"
        {
            let row = tableView.indexPathForSelectedRow?.row
            if row < itemStore.allItems.count
            {
                val = true
              
            }
            else{
                val = false
                tableView.reloadData()
            }
            
        }
        return val
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemStore.allItems.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
       
       
        if itemStore.allItems.count > indexPath.row
        {
        let item = itemStore.allItems[indexPath.row]
        cell.updateLabels(item)
        cell.namelabel.text = item.name
        cell.valueLabel.text = "$\(item.valueInDollars)"
        cell.seriallabel.text = item.serialNumber
        
        }
        else{
            cell.namelabel.text = "No More Items"
            cell.valueLabel.text = ""
             cell.seriallabel.text = ""
          
        }
         return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return itemStore.allItems.count > indexPath.row ? true:false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete
        {
            let item = itemStore.allItems[indexPath.row]
                       let title = "Delete \(item.name)"
            let message = "Are you sure yow want to delete this item"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (action)-> Void in
                //why we are using self inside the closures meaans whenever we add a contoller over the main controller(here items table view controller)
               // that new controller knows the self.
                //if we are not giving self .iemstore,alertview will check item store in alert controller not in self
                self.itemStore.removeItem(item)
                self.imageStore .deleteImageForKey(item.itemKey)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            alert.addAction(deleteAction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
       itemStore.moveItem(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        
        if proposedDestinationIndexPath.row >= itemStore.allItems.count
        {
             tableView .reloadData()
            return sourceIndexPath
        }
        else{
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }
    

 



}
