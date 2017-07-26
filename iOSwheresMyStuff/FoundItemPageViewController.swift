//
//  FoundItemPageViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import MapKit

class FoundItemPageViewController: UIViewController {

    @IBOutlet weak var itemLocation: MKMapView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Model.sharedModel.foundItemManager.selectedItem
        itemNameLabel.text = item?.name
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let dateString = formatter.string(from: (item?.date)!)
        itemDateLabel.text = dateString
        itemDescription.text = item?.description
        let location: MKPointAnnotation = (item as! FoundItem).location
        itemLocation.addAnnotation(location as MKAnnotation)

        // Do any additional setup after loading the view.
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
