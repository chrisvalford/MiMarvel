//
//  MarvelComicCreators.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct MarvelComicCreators {
    var available: Int
    var collectionURI: String
    var collectionItems = [CollectionItem]()
    var returned: Int
    
    init?(json: JSONDictionary) {
        guard let collectionURI = json["collectionURI"] as? String else {
            return nil
        }
        self.collectionURI = collectionURI
        self.available = json["available"] as! Int
        self.returned = json["returned"] as! Int
        
        
        // The collection items
        if let items = json["items"] as? NSArray { // ?? Cannot use [String : Anyobject] ??
            for i in 0 ..< items.count {
                if let creator = CollectionItem(json: items[i] as! JSONDictionary, type: .creator) {
                    self.collectionItems.append(creator)
                }
            }
        }
    }
}
