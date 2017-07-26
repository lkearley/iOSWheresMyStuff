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

        // Do any additional setup after loading the view.
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
            let alertController = UIAlertController(title: "Error", message: signOutError.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Navigation")
        self.present(vc!, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
