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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mainMap: MKMapView!
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        let itemsfound = Model.sharedModel.foundItemManager.items
        let itemsLost = Model.sharedModel.lostItemManager.items
        
        
        for item in itemsfound {
            let location: MKPointAnnotation = item.location
            mainMap.addAnnotation(location)
            
        }
        
        for item in itemsLost {
            let location: MKPointAnnotation = item.location
            mainMap.addAnnotation(location)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
