//
//  FoundItem.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class FoundItem {
    var name: String
    var description: String
    var isResolved: Bool
    var location: MKPointAnnotation
    //var category: ItemCategory
    var date: Date
    
    init?(name: String, description: String, isResolved: Bool, location: MKPointAnnotation, date: Date) {
        guard !name.isEmpty && !description.isEmpty else {
            return nil
        }
        self.name = name
        self.description = description
        self.isResolved = false
        self.location = location
        //self.category = category
        self.date = date
    }
}
