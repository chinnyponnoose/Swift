//
//  ItemCell.swift
//  Homepwner
//
//  Created by chinny ponnoose on 30/08/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var namelabel: UILabel!
    @IBOutlet var seriallabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    
    func updateLabels(item:Item)
    {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        namelabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let captionFont = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        seriallabel.font = captionFont
        
        if item.valueInDollars > 50
        {
            valueLabel.textColor = UIColor.greenColor()
        }
        else
        {
            valueLabel.textColor = UIColor.redColor()
        }
    }
}
