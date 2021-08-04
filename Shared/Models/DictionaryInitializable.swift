//
//  DictionaryInitializable.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

protocol DictionaryInitializable {
    
    init?(dictionary: JSONDictionary)
    
}
