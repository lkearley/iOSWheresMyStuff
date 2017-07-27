

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
    var searchItems: [LostItem] = [LostItem]()
    var searchFlag: Bool = false
    
    //MARK: Properites
    
    @IBOutlet weak var itemTable: UITableView!
    @IBOutlet weak var itemSearch: UISearchBar!
    
    override func viewDidLoad() {
        let ref = Database.database().reference(withPath: "lost-items")
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.items.removeAll()
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
                    self.items = Model.sharedModel.itemManager.lostItems
                }
                
                
                self.itemTable.reloadData()
            }
        })
        
        itemTable.delegate = self
        itemSearch.delegate = self
        itemTable.dataSource = self
        
        itemTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchFlag {
            return searchItems.count
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "litem", for: indexPath) as!lostItemCell
        if searchFlag {
            let item = searchItems[indexPath.item]
            let name = item.name
            cell.setName(lb: name, controller: self)
            let description = item.description
            cell.setDescription(lb: description, controller: self)
        } else {
            let item = items[indexPath.item]
            let name = item.name
            cell.setName(lb: name, controller: self)
            let description = item.description
            cell.setDescription(lb: description, controller: self)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        Model.sharedModel.itemManager.selectedLostItem = item
        self.performSegue(withIdentifier: "itemDetails", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! LostItemPageViewController
        let row = sender as! Int
        let item = items[row]
        dest.item = item
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if itemSearch == nil || itemSearch.text == "" {
            searchFlag = false
            itemTable.reloadData()
        } else {
            searchFlag = true
            searchItems = items.filter({$0.name.contains(itemSearch.text!)})
            itemTable.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
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
