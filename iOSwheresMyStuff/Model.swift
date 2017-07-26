//
//  Model.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation

class Model {
    
    static let sharedModel: Model = Model()
    
    var itemManager: ItemManager
    var userManager: UserManager
    
    init() {
        self.itemManager = ItemManager()
        self.userManager = UserManager()
    }
    
}
