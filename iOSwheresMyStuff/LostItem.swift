//
//  LostItem.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit

class LostItem: Item {
    var name: String
    var description: String
    var isResolved: Bool
    //var category: ItemCategory
    var location: String
    var reward: Int
    var date: Date
    
    init?(name: String, description: String, isResolved: Bool, reward: Int, location: String, date: Date) {
        guard !name.isEmpty && !description.isEmpty && !location.isEmpty else {
            return nil
        }
        self.name = name
        self.description = description
        self.isResolved = false
        //self.category = category
        self.location = location
        self.reward = reward
        self.date = date
    }
    
    
}
