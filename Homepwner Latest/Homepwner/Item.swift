//
//  File.swift
//  Homepwner
//
//  Created by chinny ponnoose on 26/08/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import UIKit

class Item:NSObject
{
    var name:String
    var serialNumber:String?
    var valueInDollars:Int
    var dateCreated:NSDate
    let itemKey :String
    
    init(name:String,serialNumber:String?,valueInDollars:Int,dateCreated:NSDate)
    {
        self.name = name
        self.serialNumber = serialNumber!
        self.valueInDollars = valueInDollars
        self.dateCreated = dateCreated
        self.itemKey = NSUUID().UUIDString
        super.init()
        
    }
    
    convenience init(random:Bool = false,dateCreated:NSDate)
    {
        if random
        {
            let adjectives = ["Fluffy","Rusty","Shiny"]
            let nouns = ["Bear","Spork","Mac"]
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            self.init(name:randomName,serialNumber:randomSerialNumber,valueInDollars: randomValue,dateCreated:dateCreated)
            
        }
        else{
            
            self.init(name:"",serialNumber:nil,valueInDollars: 0,dateCreated:dateCreated)
        }
    }
    
}
