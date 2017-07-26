//
//  LostItemPageViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import MapKit

class LostItemPageViewController: UIViewController {

    @IBOutlet weak var lostMap: MKMapView!
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!
    @IBOutlet weak var itemRewardLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Model.sharedModel.itemManager.selectedLostItem
        itemNameLabel.text = item?.name
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let dateString = formatter.string(from: (item?.date)!)
        itemDateLabel.text = dateString
        itemDescriptionLabel.text = item?.description
        let location: MKPointAnnotation = item!.location
        lostMap.addAnnotation(location as MKAnnotation)
        itemRewardLabel.text = "$" + "\(item?.reward ?? 0)"
        super.viewDidLoad()

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
