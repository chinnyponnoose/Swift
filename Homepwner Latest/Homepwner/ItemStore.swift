//
//  ItemStore.swift
//  Homepwner
//
//  Created by chinny ponnoose on 26/08/16.
//  Copyright © 2016 Exilant. All rights reserved.
//

import UIKit


class ItemStore
{
    var allItems = [Item]()
    
    func createItem(date:NSDate) -> Item
    {
        let newItem = Item(random: true,dateCreated:date )
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item:Item)
    {
        let index = allItems.indexOf(item)
        allItems.removeAtIndex(index!)
    }
    
    func moveItem(fromIndex:Int,toIndex:Int)
    {
        if fromIndex == toIndex
        {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.removeAtIndex(fromIndex)
        allItems.insert(movedItem, atIndex: toIndex)
    }
//
//    init()
//    {
//        for _ in 0..<5
//        {
//            createItem()
//        }
//    }
}
