//
//  Model.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation
import UIKit

final class Model {
    
    static let sharedModel: Model = Model()
    
    var itemManager: ItemManager
    var userManager: UserManager
    
    private init() {
        self.itemManager = ItemManager()
        self.userManager = UserManager()
    }
    
    func errorMessage(title: String, description: String, action: String, view: UIViewController) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: action, style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
}
