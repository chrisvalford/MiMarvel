//
//  ServiceUtils.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import UIKit
import CommonCrypto

//let apiKey = "<Your MARVEL API Key>"
//let secret = "<Your MARVEL Secret>"
let apiKey = "9471d911b8a72d8fa5b1b69379ba7d2a"
let secret = "f90dae7a6cef0d2f00cd9392eabffc695aba2ce7"

class ServiceUtils {
    
    class func md5(string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            CC_MD5((data as NSData).bytes, CC_LONG(data.count), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
    class func timestamp() -> String {
        let timestamp = Date().timeIntervalSince1970 * 1000
        return String(format:"%.0f", timestamp)
    }
    
    /**
     Provide a maximum number of items to fetch depending on device
     - Parameters: none
     
     - Return: Int fetchLimit
     */

    class func fetchLimit() -> Int {
        
        // Arbitary values which return a number of items to fill the collection view
        // If the value is too small the scroll view never scrolls, so additional items 
        // are never loaded.
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Int(screenSize.width)
        
        switch (screenWidth) {
        case 320: // iPhone
            return 100
            
        case 375: // iPhone 6
            return 45
            
        case 414: // iPhone 6+
            return 50
            
        case 768: // iPad
            return 60
            
        case 1024: // iPad Pro
            return 90
            
        default:
            return 100 // This is the maximum the API will allow
        }
        
    }
    
    class func collectionWidth() -> Int {
        
        // Arbitary values which return a number of items to fill the collection view
        // If the value is too small the scroll view never scrolls, so additional items
        // are never loaded.
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Int(screenSize.width)
        
        switch (screenWidth) {
        case 320: // iPhone
            return 2
            
        case 375: // iPhone 6
            return 2
            
        case 414: // iPhone 6+
            return 3
            
        case 768: // iPad
            return 7
            
        case 1024: // iPad Pro
            return 9
            
        default:
            return 2
        }
        
    }

}

// MARK: - Characters store CRUD operation errors

enum CharactersStoreError: Equatable, Error
{
    case cannotFetch(String)
    case cannotCreate(String)
    case cannotUpdate(String)
    case cannotDelete(String)
}

func ==(lhs: CharactersStoreError, rhs: CharactersStoreError) -> Bool
{
    switch (lhs, rhs) {
    case (.cannotFetch(let a), .cannotFetch(let b)) where a == b: return true
    case (.cannotCreate(let a), .cannotCreate(let b)) where a == b: return true
    case (.cannotUpdate(let a), .cannotUpdate(let b)) where a == b: return true
    case (.cannotDelete(let a), .cannotDelete(let b)) where a == b: return true
    default: return false
    }
}

enum URLCacheStoreError: Equatable, Error
{
    case cannotFetch(String)
    case cannotCreate(String)
    case cannotUpdate(String)
    case cannotDelete(String)
}

func ==(lhs: URLCacheStoreError, rhs: URLCacheStoreError) -> Bool
{
    switch (lhs, rhs) {
    case (.cannotFetch(let a), .cannotFetch(let b)) where a == b: return true
    case (.cannotCreate(let a), .cannotCreate(let b)) where a == b: return true
    case (.cannotUpdate(let a), .cannotUpdate(let b)) where a == b: return true
    case (.cannotDelete(let a), .cannotDelete(let b)) where a == b: return true
    default: return false
    }
}
