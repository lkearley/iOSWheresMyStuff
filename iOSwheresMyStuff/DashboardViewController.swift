//
//  DashboardViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/8/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class DashboardViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var namePlaceholderText: UILabel!
    @IBOutlet weak var profilePicImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        namePlaceholderText.text = Model.sharedModel.userManager.currentUser.name
        profilePicImage.image = Model.sharedModel.userManager.currentUser.photo

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func logout(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            Model.sharedModel.errorMessage(title: "Error", description: signOutError.localizedDescription, action: "Okay", view: self)
            return
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Navigation")
        self.present(vc!, animated: true, completion: nil)
        
    }


}
