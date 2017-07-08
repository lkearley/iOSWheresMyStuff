//
//  Admin.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit

class Admin: User {
    func unlock(user: User) {
        user.isLocked = false
    }
}
