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
    var password: String!
    var email: String!
    var name: String!
    var isLocked: Bool!
    var photo: UIImage!
    
    init?(password: String, email: String, name: String, photo: UIImage) {
        guard !password.isEmpty && !email.isEmpty && !name.isEmpty else {
            return nil
        }
        self.password = password
        self.email = email
        self.name = name
        self.isLocked = false
        self.photo = photo
    }
    
}

