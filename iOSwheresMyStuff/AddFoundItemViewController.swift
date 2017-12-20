//
//  AddFoundItemViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import Firebase

class AddFoundItemViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK:Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var foundDatePicker: UIDatePicker!
    @IBOutlet weak var foundMapView: MKMapView!
    
    var itemPin :MKPointAnnotation? = nil
    var refs: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        refs = Database.database().reference(withPath: "found-items")
        
        let longTouch = UILongPressGestureRecognizer(target: self, action: #selector(self.addPin))
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddLostItemViewController.dismissKeyboard))
        longTouch.minimumPressDuration = 1
        longTouch.delegate = self
        foundMapView.addGestureRecognizer(longTouch)
        view.addGestureRecognizer(tap)

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        if nameTextField.text == "" || descriptionTextField.text == "" || itemPin == nil {
            Model.sharedModel.errorMessage(title: "Error", description: "Please enter valid information for all fields", action: "Okay", view: self)
            return
        }
        itemPin?.title = nameTextField.text!
        itemPin?.subtitle = descriptionTextField.text!
        
        let newItem = FoundItem(name: nameTextField.text!,description: descriptionTextField.text!, location: itemPin!, date: foundDatePicker.date, posterEmail: Model.sharedModel.userManager.currentUser.email)!
        
        let flag: Bool = Model.sharedModel.itemManager.addFoundItem(item: newItem)
        
        if !flag {
            Model.sharedModel.errorMessage(title: "Error", description: "There was a problem adding your item, please try again", action: "Okay", view: self)
            return
        } else {
            let coordinate: CLLocationCoordinate2D = (itemPin?.coordinate)!
            let log = coordinate.longitude
            let lati = coordinate.latitude
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yyyy"
            let dateString = formatter.string(from: (newItem.date))
            let key = refs.childByAutoId().key
            
            let item = ["name": nameTextField.text! as String,
                        "description": descriptionTextField.text! as String,
                        "latitude": String(lati),
                        "longitude": String(log),
                        "date": dateString,
                        "key": key,
                        "contact": newItem.posterEmail
                        ]
            
            refs.child(key).setValue(item)
            //TODO: Change this
            Model.sharedModel.errorMessage(title: "Success", description: "Item Added", action: "Okay", view: self)
        }
    }
    
    func addPin(longTouch: UILongPressGestureRecognizer) -> Bool {
        let touchPoint = longTouch.location(in: foundMapView)
        let pinCoordinates = foundMapView.convert(touchPoint, toCoordinateFrom: foundMapView)
        itemPin = MKPointAnnotation()
        itemPin?.coordinate = pinCoordinates
        foundMapView.addAnnotation(itemPin!)
        return true
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }


}
