

//
//  LostItemTableViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MapKit

class LostItemTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    var items: [LostItem] = [LostItem]()
    //MARK: Properites
    @IBOutlet weak var itemSearch: UISearchBar!
    @IBOutlet weak var itemTable: UITableView!
    
    override func viewDidLoad() {
        let ref = Database.database().reference(withPath: "lost-items")
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.items.removeAll()
                
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
                    self.items = Model.sharedModel.itemManager.lostItems
                }
                
                
                self.itemTable.reloadData()
            }
        })
        
        itemTable.delegate = self
        itemSearch.delegate = self
        itemTable.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "litem", for: indexPath) as!lostItemCell
        let item = items[indexPath.item]
        let name = item.name
        cell.setName(lb: name, controller: self)
        let description = item.description
        cell.setDescription(lb: description, controller: self)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        Model.sharedModel.itemManager.selectedLostItem = item
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LostItemPage")
        self.present(vc!, animated: true, completion: nil)
        
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

class lostItemCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPic: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setName(lb: String, controller: LostItemTableViewController) {
        self.itemNameLabel.text = lb
    }
    
    func setDescription(lb: String, controller: LostItemTableViewController) {
        self.itemDescriptionLabel.text = lb
    }
    
}
