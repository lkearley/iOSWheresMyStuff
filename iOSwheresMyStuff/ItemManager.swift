//
//  ItemManager.swift
//  FindMyStuff_iOS
//
//  Created by Lauren Kearley on 7/7/17.
//  Copyright © 2017 Lauren Kearley. All rights reserved.
//

import Foundation

class ItemManager {
    var foundItems: [FoundItem]
    var selectedFoundItem: FoundItem? = nil
    var lostItems: [LostItem]
    var selectedLostItem: LostItem? = nil
    
    init() {
        self.foundItems = [FoundItem]()
        self.lostItems = [LostItem]()
        
    }
    
    func addFoundItem(item: FoundItem) -> Bool {
        foundItems.append(item)
        return true
    }
    
    func addLostItem(item: LostItem) -> Bool {
        lostItems.append(item)
        return true
    }
    
//    func search(query: String) -> [Item] {
//        var searchResults = [Item]()
//        if query.isEmpty {
//            return searchResults
//        }
//        for item in items {
//            if item.name == query {
//                searchResults.append(item)
//            }
//        }
//        return searchResults
//    }
}
