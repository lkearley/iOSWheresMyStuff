//
//  RegistrationViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/8/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistrationViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "texture")!)
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func registrationButtonPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
