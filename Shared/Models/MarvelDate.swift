//
//  MarvelDate.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct MarvelDate {
    
    enum DateType: String {
        case onsaleDate,
        focDate,
        unlimitedDate,
        digitalPurchaseDate
    }
    
    var type: DateType
    var date: String
    
    init?(json: JSONDictionary) {
        guard let date = json["date"] as? String else {
            return nil
        }
        self.type = DateType(rawValue: json["type"] as! String)!
        self.date = date
    }
}
