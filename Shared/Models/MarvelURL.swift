//
//  MarvelURL.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation


struct MarvelURL {
    var type: String? // detail, wiki, comiclink
    var url: String? // "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=9471d911b8a72d8fa5b1b69379ba7d2a"
    
    /**
     Initializes a new MarvelURL with the provided attributes.
     
     - Parameters: [String: AnyObject]
     
     - Returns: An MarvelURL item or nil
     */
    init?(attributes: [String: Any]) {
        
        self.type = attributes["type"] as? String
        self.url = attributes["url"] as? String
    }
    
    /**
     Initializes a new MarvelURL with the provided parameters.
     
     - Parameters: type: String, url: String
     
     - Returns: An MarvelURL item or nil
     */
    init?(type: String, url: String) {
        self.type = type
        self.url = url
    }
    
}
