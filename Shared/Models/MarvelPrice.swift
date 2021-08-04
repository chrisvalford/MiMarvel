//
//  MarvelPrice.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct MarvelPrice {
    
    enum PriceType: String {
        case printPrice,
        digitalPurchasePrice
    }
    
    var type: String
    var price: Double
}
