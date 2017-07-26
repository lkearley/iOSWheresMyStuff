//
//  AddLostItemViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/13/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class AddLostItemViewController: UIViewController, UIPickerViewDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    
    //MARK: Properties 
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var descriptionItemLabel: UILabel!
    @IBOutlet weak var dateFoundLabel: UILabel!
    @IBOutlet weak var locationFoundLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var descriptionItemTextField: UITextField!
    @IBOutlet weak var rewardTextField: UITextField!
    @IBOutlet weak var lostDatePicker: UIDatePicker!
    
    @IBOutlet weak var lastKnownLocationMap: MKMapView!
    
    var itemPin :MKPointAnnotation? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longTouch = UILongPressGestureRecognizer(target: self, action: #selector(self.addPin))
        longTouch.minimumPressDuration = 1
        longTouch.delegate = self
        lastKnownLocationMap.addGestureRecognizer(longTouch)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    @IBAction func onAddItemPressed(_ sender: UIButton) {
        if itemNameTextField.text == "" || descriptionItemTextField.text == "" || rewardTextField.text == "" || itemPin == nil {
            let alertController = UIAlertController(title: "Error", message: "Please enter valid information for all fields", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        itemPin?.title = itemNameTextField.text!
        itemPin?.subtitle = descriptionItemTextField.text!
        
        let flag: Bool = Model.sharedModel.itemManager.addLostItem(item: LostItem(name: itemNameTextField.text!,description: descriptionItemTextField.text!, isResolved: false, reward: Int(rewardTextField.text!)!, location: itemPin!, date: lostDatePicker.date)!)
        
        if !flag {
            let alertController = UIAlertController(title: "Error", message: "Error adding item, please try again", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            let alertController = UIAlertController(title: "Success", message: "Item Added", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func addPin(longTouch: UILongPressGestureRecognizer) -> Bool {
        let touchPoint = longTouch.location(in: lastKnownLocationMap)
        let pinCoordinates = lastKnownLocationMap.convert(touchPoint, toCoordinateFrom: lastKnownLocationMap)
        itemPin = MKPointAnnotation()
        itemPin?.coordinate = pinCoordinates
        lastKnownLocationMap.addAnnotation(itemPin!)
        return true
        
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
