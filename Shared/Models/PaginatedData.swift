//
//  PaginatedData.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct PaginatedData: DictionaryInitializable, Equatable {
    
    // MARK: - Structures
    
    struct Pagination: Equatable {
        
        struct JSONKeys {
            static let bucket = "closetBucket"
            static let bucketSize = "closetBucketSize"
            static let totalBuckets = "totalClosetBuckets"
            static let productCount = "productsInCurrentBucket"
        }
        
        
        let bucket: Int
        let bucketSize: Int
        let totalBuckets: Int
        let productCount: Int
        
        
        init(bucket: Int, bucketSize: Int, totalBuckets: Int, productCount: Int) {
            self.bucket = bucket
            self.bucketSize = bucketSize
            self.totalBuckets = totalBuckets
            self.productCount = productCount
        }
        
        init?(dictionary: JSONDictionary) {
            guard let bucket = dictionary[JSONKeys.bucket] as? Int else { return nil }
            guard let bucketSize = dictionary[JSONKeys.bucketSize] as? Int else { return nil }
            guard let totalBuckets = dictionary[JSONKeys.totalBuckets] as? Int else { return nil }
            guard let productCount = dictionary[JSONKeys.productCount] as? Int else { return nil }
            
            self.init(bucket: bucket, bucketSize: bucketSize, totalBuckets: totalBuckets, productCount: productCount)
        }
        
        static func ==(lhs: Pagination, rhs: Pagination) -> Bool {
            return lhs.bucket == rhs.bucket &&
                lhs.bucketSize == rhs.bucketSize &&
                lhs.productCount == rhs.productCount &&
                lhs.totalBuckets == rhs.totalBuckets
        }
    }
    
    struct Product {
        
        struct JSONKeys {
            static let hint = "hint"
            static let imageUrl = "imageUrl"
            static let itemId = "itemId"
            static let label = "label"
            static let mediumId = "mediumId"
            static let productId = "productId"
            static let target = "target"
        }
        
        
        let hint: String?
        let imageUrl: URL
        let itemId: String
        let label: String
        let mediumId: String
        let productId: String?
        let target: URL
        
        
        init(hint: String?, imageUrl: URL, itemId: String, label: String, mediumId: String, productId: String?, target: URL) {
            self.hint = hint
            self.imageUrl = imageUrl
            self.itemId = itemId
            self.label = label
            self.mediumId = mediumId
            self.productId = productId
            self.target = target
        }
        
        init?(dictionary: JSONDictionary) {
            guard let imageUrlString = dictionary[JSONKeys.imageUrl] as? String,
                let imageUrl = URL(string: imageUrlString) else { return nil }
            guard let itemId = dictionary[JSONKeys.itemId] as? String else { return nil }
            guard let label = dictionary[JSONKeys.label] as? String else { return nil }
            guard let mediumId = dictionary[JSONKeys.mediumId] as? String else { return nil }
            
            guard let targetString = dictionary[JSONKeys.target] as? String,
                let target = URL(string: targetString) else { return nil }
            
            let hint = dictionary[JSONKeys.hint] as? String
            let productId = dictionary[JSONKeys.productId] as? String
            
            self.init(hint: hint, imageUrl: imageUrl, itemId: itemId, label: label, mediumId: mediumId, productId: productId, target: target)
        }
    }
    
    struct JSONKeys {
        static let pagination = "closetPagination"
        static let products = "products"
    }
    
    // MARK: - Properties
    
    let pagination: PaginatedData.Pagination
    let products: [PaginatedData.Product]
    
    // MARK: - Initializers
    
    init(pagination: PaginatedData.Pagination, products: [PaginatedData.Product]) {
        self.pagination = pagination
        self.products = products
    }
    
    init?(dictionary: JSONDictionary) {
        guard let paginationDict = dictionary[JSONKeys.pagination] as? JSONDictionary,
            let pagination = PaginatedData.Pagination(dictionary: paginationDict) else { return nil }
        guard let productDicts = dictionary[JSONKeys.products] as? [JSONDictionary] else { return nil }
        
        let products = productDicts.compactMap { PaginatedData.Product(dictionary: $0) }
        
        self.init(pagination: pagination, products: products)
    }
    
    // MARK: - Equatable
    
    static func ==(lhs: PaginatedData, rhs: PaginatedData) -> Bool {
        return lhs.pagination == rhs.pagination
    }
}

extension PaginatedData {
    
    static func fetch(partnerId: String, bucket: Int, bucketSize: Int, completion: @escaping ((DataFetcher.Result<PaginatedData>) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "snap-api.geeneeapi.com"
        urlComponents.path = "/api/v1/influencerProfile/\(partnerId)/closetData"
        let closetBucket = URLQueryItem(name: "closetBucket", value: "\(bucket)")
        let closetBucketSize = URLQueryItem(name: "closetBucketSize", value: "\(bucketSize)")
        urlComponents.queryItems = [closetBucket, closetBucketSize]
        
        // TODO: Get real values from somewhere
        let language = "en_US"
        let market = "en_US"
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue(language, forHTTPHeaderField: "Accept-Language")
        request.setValue(market, forHTTPHeaderField: "X-Target-Market")
        
        DataFetcher.fetch(request: request, completion: completion)
    }
    
}
