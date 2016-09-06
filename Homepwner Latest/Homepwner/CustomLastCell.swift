//
//  CustomLastCell.swift
//  Homepwner
//
//  Created by chinny ponnoose on 30/08/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import UIKit

class CustomLastCell: UITableViewCell {
    
    var label  = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView .addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label = UILabel(frame:CGRectMake(20, 10, 70, 44))
        
    }
    
}
