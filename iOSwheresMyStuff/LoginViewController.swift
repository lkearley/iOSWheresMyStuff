//
//  LoginViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit


class LoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "texture")!)
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func forgotPass(_ sender: UIButton) {
        var email = ""
        let alertController = UIAlertController(title: "Recover Password", message: "please enter account email", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Send Password", style: .default, handler: {
            alert -> Void in
            
            let emailTextField = alertController.textFields![0] as UITextField
            email = emailTextField.text!
            
        })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter email"
        }
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
        
        if email != "" {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
            }
            
            
        }
    }
    
    @IBAction func attemptLogin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: self.usernameTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            let url: UIImage = UIImage(named: "UserDefault")!
            let delimiter = "@"
            let newstr = self.usernameTextField.text!
            var token = newstr.components(separatedBy: delimiter)
            let userName = token[0]
            
            
            
            Model.sharedModel.userManager.currentUser = User(password: self.passwordTextField.text!, email: self.usernameTextField.text!, name: userName, photo: url)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tab")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func attemptFacebookLogin(_ sender: UIButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                let user = Auth.auth().currentUser;
                let userName: String = (user?.displayName)!
                let userEmail: String = (user?.email)!
                var url: UIImage = UIImage(named: "UserDefault")!
                
                if (user != nil) {
                    if let imageData: NSData = NSData(contentsOf: (user?.photoURL)! as URL) {
                        url = UIImage(data: imageData as Data)!
                    }
                }
                Model.sharedModel.userManager.currentUser = User(password: "N/A", email: userEmail, name: userName, photo: url)
                
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Tab") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            
        }
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
