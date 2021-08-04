//
//  MarvelComicResult.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct MarvelComicResult {
    var id: Int?
    var digitalId: Int?
    var title: String?
    var issueNumber: Int?
    var variantDescription: String?
    var description: String?
    var modified: String?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String? // enum "comic"
    var pageCount: Int?
    var textObjects: [TextObject]?
    var resourceURI: String?
    var urls: [MarvelURL]?
    var series: CollectionItem? // CollectionItemType.series
    var variants: [Any]?
    var collections: [Any]?
    var collectedIssues: [Any]?
    var dates: [MarvelDate]?
    var prices: [MarvelPrice]?
    var thumbnail: ImagePath?
    var images: [ImagePath]?
    var creators: MarvelComicCreators?
    var characters: MarvelCharacters?
    var stories: MarvelStories?
    var events: MarvelEvents?
    
    init?(json: JSONDictionary) {
        self.id = json["id"] as? Int
        self.digitalId = json["digitalId"] as? Int
        self.title = json["title"] as? String
        self.issueNumber = json["issueNumber"] as? Int
        self.variantDescription = json["variantDescription"] as? String
        self.description = json["description"] as? String
        self.modified = json["modified"] as? String
        self.isbn = json["isbn"] as? String
        self.upc = json["upc"] as? String
        self.diamondCode = json["diamondCode"] as? String
        self.ean = json["ean"] as? String
        self.issn = json["issn"] as? String
        self.format = json["format"] as? String // enum "comic"
        self.pageCount = json["pageCount"] as? Int
        self.textObjects = [] // [MMTextObject]
        self.resourceURI = json["resourceURI"] as? String
        self.urls = [] // [MMURL]
        self.series = CollectionItem(json: json["series"] as! JSONDictionary, type: .series)! // MMCollectionItem // CollectionItemType.series
        self.variants = [] // [Any]
        self.collections = [] // [Any]
        self.collectedIssues = [] // [Any]
        self.dates = [MarvelDate]()
        let newDates = json["dates"] as! [JSONDictionary]
        for date in newDates {
            if let newDate = MarvelDate(json: date) {
                self.dates?.append(newDate)
            }
        }
        
        self.prices = [MarvelPrice]()
        self.thumbnail = ImagePath(json: json["thumbnail"] as! JSONDictionary)!
        self.images = [ImagePath]()
        self.creators = MarvelComicCreators(json: json["creators"] as! JSONDictionary)!
        self.characters = MarvelCharacters(json: json["characters"] as! JSONDictionary)!
        self.stories = MarvelStories(json: json["stories"] as! JSONDictionary)!
        self.events = MarvelEvents(json: json["events"] as! JSONDictionary)!
        
    }
}
