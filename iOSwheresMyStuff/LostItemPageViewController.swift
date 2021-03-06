//
//  LostItemPageViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit

import MapKit
import MessageUI

class LostItemPageViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var lostMap: MKMapView!
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!
    @IBOutlet weak var itemRewardLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    var item: LostItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item = Model.sharedModel.itemManager.selectedLostItem!
        itemNameLabel.text = item?.name
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let dateString = formatter.string(from: (item?.date)!)
        itemDateLabel.text = dateString
        itemDescriptionLabel.text = item?.description
        let location: MKPointAnnotation = item!.location
        lostMap.addAnnotation(location as MKAnnotation)
        itemRewardLabel.text = "$" + "\(item!.reward)"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func sendEmail(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            Model.sharedModel.errorMessage(title: "Error", description: "There was a problem sending your email, please try again", action: "Okay", view: self)
            return
        }
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(Model.sharedModel.itemManager.selectedLostItem!.posterEmail)])
        mailComposerVC.setSubject("Where's My Stuff: Lost Item Inquiry")
        
        return mailComposerVC
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
