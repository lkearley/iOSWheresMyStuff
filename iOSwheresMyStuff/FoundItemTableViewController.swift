//
//  FoundItemTableViewController.swift
//  iOSwheresMyStuff
//
//  Created by Lauren Kearley on 7/25/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import UIKit

class FoundItemTableViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource {

    
    var items: [Item] = [Item]()
    //MARK:Properties
    @IBOutlet weak var foundSearch: UISearchBar!
    @IBOutlet weak var foundTable: UITableView!

    override func viewDidLoad() {
        items = Model.sharedModel.foundItemManager.items
        foundTable.delegate = self
        foundSearch.delegate = self
        foundTable.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as!ItemCell
        let item = items[indexPath.item]
        let name = item.name
        cell.setName(lb: name, controller: self)
        let description = item.description
        cell.setDescription(lb: description, controller: self)
        
        return cell
        
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

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameCellLabel: UILabel!
    @IBOutlet weak var descriptionCellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setName(lb: String, controller: FoundItemTableViewController) {
        self.nameCellLabel.text = lb
    }
    
    func setDescription(lb: String, controller: FoundItemTableViewController) {
        self.descriptionCellLabel.text = lb
    }
    
    
}
