//
//  CollectionItem.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

enum CollectionItemType: String {
    case unknown,
    character,
    comics,
    creator,
    series,
    stories,
    events,
    urls
}

struct CollectionItem {
    
    var collectionItemType: CollectionItemType = .unknown
    
    var resourceURI: String?    // "http://gateway.marvel.com/v1/public/comics/21366"
    var name: String?           // "Avengers: The Initiative (2007) #14"
    var type: String?           // "cover"
    var role: String?           // Only in Creator "inker"
    
    /**
    Initializes a new CollectionItem with the provided attributes.
    
    - Parameters: JSONDictionary
    
    - Returns: An CollectionItem item or nil
    */
    init?(json: JSONDictionary, type: CollectionItemType) {
        
        guard let resourceURI = json["resourceURI"] as? String, let name = json["name"] as? String else {
            return nil
        }
        
        self.type = type.rawValue
        self.resourceURI = resourceURI
        self.name = name
        self.role = json["role"] as? String
    }
    
    /**
     Initializes a new CollectionItem with the provided parameters.
     
     - Parameters: collectionItemType: CollectionItemType,
     resourceURI: String,
     name: String,
     type: String
     
     - Returns: An CollectionItem item or nil
     */
    init?(collectionItemType: String,
          resourceURI: String,
          name: String,
          type: String,
          role: String) {
        
        self.collectionItemType = CollectionItemType(rawValue: collectionItemType)!
        self.resourceURI = resourceURI
        self.name = name
        self.type = type
        self.role = role
    }
    
    

}
