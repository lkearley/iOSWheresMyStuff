//
//  Item.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol Item {
    var name: String {get}
    var description: String {get}
    var isResolved: Bool {get}
    var location: MKPointAnnotation {get}
    //var category: ItemCategory {get}
    var date: Date {get}
}
