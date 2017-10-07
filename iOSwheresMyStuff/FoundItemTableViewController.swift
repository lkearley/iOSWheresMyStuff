//
//  FoundItemTableViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class FoundItemTableViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource {

    var searchFlag: Bool = false
    var items: [FoundItem] = [FoundItem]()
    var searchItems: [FoundItem] = [FoundItem]()
    //MARK:Properties
    @IBOutlet weak var foundSearch: UISearchBar!
    @IBOutlet weak var foundTable: UITableView!
    

    override func viewDidLoad() {
        let ref = Database.database().reference(withPath: "found-items")
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.items.removeAll()
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
                    self.items = Model.sharedModel.itemManager.foundItems
                }
                
                
                self.foundTable.reloadData()
            }
        })
        
        foundTable.delegate = self
        foundSearch.delegate = self
        foundTable.dataSource = self
        
        foundTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if foundSearch == nil || foundSearch.text == "" {
            searchFlag = false
            foundTable.reloadData()
        } else {
            searchFlag = true
            searchItems = items.filter({$0.name.contains(foundSearch.text!)})
            foundTable.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        Model.sharedModel.itemManager.selectedFoundItem = item
        self.performSegue(withIdentifier: "showItemDetails", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showItemDetails") {
            let dest = segue.destination as! FoundItemPageViewController
            let row = sender as! Int
            let item = items[row]
            dest.item = item
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as!ItemCell
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



}

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameCellLabel: UILabel!
    @IBOutlet weak var descriptionCellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setName(lb: String, controller: FoundItemTableViewController) {
        self.nameCellLabel.text = lb
    }
    
    func setDescription(lb: String, controller: FoundItemTableViewController) {
        self.descriptionCellLabel.text = lb
    }
    
    
}
