//
//  Item.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit

protocol Item {
    var name: String {get}
    var description: String {get}
    var isResolved: Bool {get}
    var category: ItemCategory {get}
    var date: NSDate {get}
}
