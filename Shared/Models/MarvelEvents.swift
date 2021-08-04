//
//  MarvelEvents.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct MarvelEvents {
    var available: Int
    var collectionURI: String
    var items: [CollectionItem] // CollectionItemType.events
    var returned: Int
    
    init?(json: JSONDictionary) {
        guard let collectionURI = json["collectionURI"] as? String else {
            return nil
        }
        self.collectionURI = collectionURI
        self.available = json["available"] as! Int
        self.returned = json["returned"] as! Int
        
        //TODO:
        self.items = [CollectionItem]()
    }
}
