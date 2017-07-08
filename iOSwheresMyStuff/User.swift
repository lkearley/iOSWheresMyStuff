//
//  User.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 6/29/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit

class User {
    var id: String!
    var password: String!
    var email: String!
    var isLocked: Bool!
    
    init?(id: String, password: String, email: String) {
        guard !id.isEmpty && !password.isEmpty && !email.isEmpty else {
            return nil
        }
        self.id = id
        self.password = password
        self.email = email
        self.isLocked = false
    }
    
}

