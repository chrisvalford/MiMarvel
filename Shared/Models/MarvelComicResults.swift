//
//  MarvelComicResults.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct MarvelComicResults {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    
    // JSON Group "results":
    var comics = [MarvelComicResult]()
    
    init?(json: JSONDictionary) {
        
        // Populate the MarvelComicResults, count values
        self.offset = json["offset"] as! Int
        self.limit = json["limit"] as! Int
        self.total = json["total"] as! Int
        self.count = json["count"] as! Int
        
        if let resultsJSON = json["results"] as? [JSONDictionary] {
            
            for result in resultsJSON {
                if let newComic = MarvelComicResult(json: result) {
                    comics.append(newComic)
                }
            }
        }
    }
}
