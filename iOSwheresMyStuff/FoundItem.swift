//
//  FoundItem.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit

class FoundItem: Item {
    var name: String
    var description: String
    var isResolved: Bool
    var category: ItemCategory
    var date: NSDate
    
    init?(name: String, description: String, isResolved: Bool, category: ItemCategory, date:NSDate) {
        guard !name.isEmpty && !description.isEmpty else {
            return nil
        }
        self.name = name
        self.description = description
        self.isResolved = false
        self.category = category
        self.date = date
    }
}
