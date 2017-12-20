//
//  FoundItemPageViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class FoundItemPageViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var itemLocation: MKMapView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDescription: UILabel!
    
    
    var item: FoundItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Model.sharedModel.itemManager.selectedFoundItem
        itemNameLabel.text = item?.name
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let dateString = formatter.string(from: (item?.date)!)
        itemDateLabel.text = dateString
        itemDescription.text = item?.description
        let location: MKPointAnnotation = (item!).location
        itemLocation.addAnnotation(location as MKAnnotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(Model.sharedModel.itemManager.selectedFoundItem!.posterEmail)])
        mailComposerVC.setSubject("Where's My Stuff: Found Item Inquiry")
        
        return mailComposerVC
    }
    
    @IBAction func sendEmailButton(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            Model.sharedModel.errorMessage(title: "Error", description: "There was a problem sending your email, please try again", action: "Okay", view: self)
            return
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

}
