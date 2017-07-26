//
//  LostItem.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LostItem {
    var name: String
    var description: String
    //var isResolved: Bool
    //var category: ItemCategory
    var location: MKPointAnnotation
    var reward: Int
    var date: Date
    var posterEmail: String
    
    init?(name: String, description: String, reward: Int, location: MKPointAnnotation, date: Date, posterEmail: String) {
        guard !name.isEmpty && !description.isEmpty && !posterEmail.isEmpty else {
            return nil
        }
        self.name = name
        self.description = description
        //self.isResolved = false
        //self.category = category
        self.location = location
        self.reward = reward
        self.date = date
        self.posterEmail = posterEmail
    }
    
    
}
