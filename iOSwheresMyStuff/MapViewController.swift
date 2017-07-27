//
//  MapViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/12/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //MARK:Properites
    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var refreshButton: UIButton!
    var manager:CLLocationManager!
    var refLost: DatabaseReference!
    var refFound: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refLost = Database.database().reference(withPath: "lost-items")
        refFound = Database.database().reference(withPath: "found-items")
        self.loadItems()
    
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        mainMap.showsUserLocation = true
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
    }
    
    func loadItems() {
        let itemsfound = Model.sharedModel.itemManager.foundItems
        let itemsLost = Model.sharedModel.itemManager.lostItems
        
        refLost.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                Model.sharedModel.itemManager.lostItems.removeAll()
                
                //iterating through all the values
                for item in snapshot.children.allObjects as! [DataSnapshot] {
                    let Object = item.value as? [String: AnyObject]
                    let itemName  = Object?["name"]
                    let itemDescription  = Object?["description"]
                    let itemReward = Object?["reward"]
                    let itemDate = Object?["date"]
                    let itemLat = Object?["latitude"]
                    let itemLong = Object?["longitude"]
                    let itemEmail = Object?["contact"]
                    
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MMM-yyyy"
                    let date = formatter.date(from: itemDate as! String)
                    let lat = (itemLat)?.doubleValue
                    let longi = (itemLong)?.doubleValue
                    let coordinates = CLLocationCoordinate2D(latitude: lat!, longitude: longi!)
                    let pin = MKPointAnnotation()
                    pin.coordinate = coordinates
                    pin.title = itemName as? String
                    pin.subtitle = itemDescription as? String
                    let item = LostItem(name: itemName as! String, description: itemDescription as! String, reward: Int(itemReward as! String)!, location: pin, date: date!, posterEmail: itemEmail as! String)
                    
                    _ = Model.sharedModel.itemManager.addLostItem(item: item!)
                }
            }
        })
        
        refFound.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                Model.sharedModel.itemManager.foundItems.removeAll()
                
                //iterating through all the values
                for item in snapshot.children.allObjects as! [DataSnapshot] {
                    let Object = item.value as? [String: AnyObject]
                    let itemName  = Object?["name"]
                    let itemDescription  = Object?["description"]
                    let itemDate = Object?["date"]
                    let itemLat = Object?["latitude"]
                    let itemLong = Object?["longitude"]
                    let itemEmail = Object?["contact"]
                    
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MMM-yyyy"
                    let date = formatter.date(from: itemDate as! String)
                    let lat = (itemLat)?.doubleValue
                    let longi = (itemLong)?.doubleValue
                    let coordinates = CLLocationCoordinate2D(latitude: lat!, longitude: longi!)
                    let pin = MKPointAnnotation()
                    pin.coordinate = coordinates
                    pin.title = itemName as? String
                    pin.subtitle = itemDescription as? String
                    let item = FoundItem(name: itemName as! String, description: itemDescription as! String, location: pin, date: date!, posterEmail: itemEmail as! String)
                    
                    _ = Model.sharedModel.itemManager.addFoundItem(item: item!)
                }
                
            }
        })
        
        
        for item in itemsfound {
            let location: MKPointAnnotation = item.location
            self.mainMap.addAnnotation(location)
            
        }
        
        for item in itemsLost {
            let location: MKPointAnnotation = item.location
            self.mainMap.addAnnotation(location)
        }
    }

    @IBAction func Refresh(_ sender: UIButton) {
        loadItems()
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
