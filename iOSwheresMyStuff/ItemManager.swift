//
//  ItemManager.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation

class ItemManager {
    var items: [Item]
    var selectedItem: Item? = nil
    
    init() {
        self.items = [Item]()
    }
    
    func addItem(item: Item) -> Bool {
        items.append(item)
        return true
    }
    
    func search(query: String) -> [Item] {
        var searchResults = [Item]()
        if query.isEmpty {
            return searchResults
        }
        for item in items {
            if item.name == query {
                searchResults.append(item)
            }
        }
        return searchResults
    }
}
