//
//  MarvelCharacter.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import UIKit

struct MarvelCharacter {
    
    // The current collection of characters
    static var characters: [MarvelCharacter]?
    
    // Character attributes
    var id: Int?                // The unique ID of the character resource.
    var name: String?           // The name of the character.
    var description: String?    // A short bio or description of the character.
    var modified: String?       // The date the resource was most recently modified.
    var resourceURI = ""        // The canonical URL identifier for this resource.to
    
    // The representative image for this character.
    var thumbnailPath = ""
    var thumbnailExtension = ""
    
    var comicsAvailable = 0
    var comicsCollectionURI: String?
    
    var seriesAvailable = 0
    var seriesCollectionURI: String?
    
    var storiesAvailable = 0
    var storiesCollectionURI: String?
    
    var eventsAvailable = 0
    var eventsCollectionURI: String?
    
    var favourite = false
    var imageSize = CGSize.zero
    
    //TODO: Make these lazy
    var comics = ComicList()    // A resource list containing comics which feature this character.
    var stories = StoryList()   // A resource list of stories in which this character appears.
    var events = EventList()    // A resource list of events in which this character appears.
    var series = SeriesList()   // A resource list of series in which this character appears.
    var urls = [MarvelURL]()    // A set of public web site URLs for the resource.
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        if (description?.isEmpty)! {
            return 0.0
        }
        let rect = NSString(string: description!).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    /**
     Initializes a new MarvelCharacter with the provided attributes.
     
     - Parameters: [String: AnyObject]
     
     - Returns: An MarvelCharacter item or nil
     */
    
    init?(attributes: JSONDictionary) {
        
        guard let id = attributes["id"] as? Int else { return nil }
        
        self.id = id
        self.name = attributes["name"] as? String
        self.description = attributes["description"] as? String
        self.modified = attributes["modified"] as? String // "2014-04-29T14:18:17-0400"
        
        // Get the thumbnail image path
        if let thumbnail = attributes["thumbnail"] as? JSONDictionary {
            self.thumbnailPath = (thumbnail["path"] as? String)!
            self.thumbnailExtension = (thumbnail["extension"] as? String)!
        }
        //
        //self.resourceURI = attributes["id"] as? String
        //self.urls = attributes["id"] as? Array<NSURL>
        //self.thumbnail = attributes["id"] as? UIImage
        
        // Read the comic items
        if let comics = attributes["comics"] as? JSONDictionary {
            self.comicsAvailable = (comics["available"] as? Int)!
            self.comicsCollectionURI = comics["collectionURI"] as? String
            
            // The comic items
            if let items = comics["items"] as? NSArray { // ?? Cannot use [String : Anyobject] ??
                for i in 0 ..< items.count {
                    if let comic = CollectionItem(json: items[i] as! JSONDictionary, type: .comics) {
                        self.comics.append(comic)
                    }
                }
            }
        }
        
        // Read the series items
        if let series = attributes["series"] as? JSONDictionary {
            self.seriesAvailable = (series["available"] as? Int)!
            self.seriesCollectionURI = series["collectionURI"] as? String
            
            // The series items
            if let items = series["items"] as? NSArray { // ?? Cannot use [String : Anyobject] ??
                for i in 0 ..< items.count {
                    if let series = CollectionItem(json: items[i] as! JSONDictionary, type: .series) {
                        self.series.append(series)
                    }
                }
            }
        }
        
        // Read the stories items
        if let stories = attributes["stories"] as? JSONDictionary {
            self.storiesAvailable = (stories["available"] as? Int)!
            self.storiesCollectionURI = stories["collectionURI"] as? String
            
            // The stories items
            if let items = stories["items"] as? NSArray { // ?? Cannot use [String : Anyobject] ??
                for i in 0 ..< items.count {
                    if let story = CollectionItem(json: items[i] as! JSONDictionary, type: .stories) {
                        self.stories.append(story)
                    }
                }
            }
        }
        
        // Read the events items
        if let events = attributes["events"] as? JSONDictionary {
            self.eventsAvailable = (events["available"] as? Int)!
            self.eventsCollectionURI = events["collectionURI"] as? String
            
            // The events items
            if let items = events["items"] as? NSArray { // ?? Cannot use [String : Anyobject] ??
                for i in 0 ..< items.count {
                    if let event = CollectionItem(json: items[i] as! JSONDictionary, type: .events) {
                        self.events.append(event)
                    }
                }
            }
        }
        
        // Read the urls
        if let urls = attributes["urls"] as? JSONDictionary {
            
            // The events items
            if let items = urls["items"] as? NSArray { // ?? Cannot use [String : Anyobject] ??
                for i in 0 ..< items.count {
                    if let url = MarvelURL(attributes: items[i] as! JSONDictionary) {
                        self.urls.append(url)
                    }
                }
            }
        }
    }
}

extension MarvelCharacter {
    
    static func fetchRemote() -> Promise<(Data, HTTPURLResponse)> {
        return Promise<(Data, HTTPURLResponse)>( work: { fulfill, reject in
            
            var task: URLSessionDataTask?
            //            var urlComponents = URLComponents()
            //            urlComponents.scheme = "https"
            //            urlComponents.host = "gateway.marvel.com"
            //            urlComponents.path = "/v1/public/characters"
            //
            //            // Add the parameters
            let ts = ServiceUtils.timestamp()
            //            let pageQueryItem = URLQueryItem(name: "offset", value: "0")
            //            let pageSizeQueryItem = URLQueryItem(name: "limit", value: "\(MMServiceUtils.fetchLimit())")
            //            let apiQueryItem = URLQueryItem(name: "apikey", value :"\(apiKey)")
            //            let timestampQueryItem = URLQueryItem(name: "ts", value: ts)
            //            let hashQueryItem = URLQueryItem(name: "hash", value: "\(MMServiceUtils.md5(string: ts + secret + apiKey))")
            //
            //            urlComponents.queryItems? = [pageQueryItem, pageSizeQueryItem, apiQueryItem, timestampQueryItem, hashQueryItem]
            //            var request = URLRequest(url: urlComponents.url!)
            
            
            
            let urlPath = "http://gateway.marvel.com/v1/public/characters?offset=\(0)&limit=\(100)&apikey=\(apiKey)&ts=\(ts)&hash=\(ServiceUtils.md5(string: ts + secret + apiKey))"
            let url = URL(string: urlPath)
            print("URL : \(urlPath)")
            var request = URLRequest(url: url!)
            
            
            // Add the header data
            request.setValue("*/*", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            
            task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                if let error = error {
                    reject(error)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    fulfill((data, response))
                } else {
                    fatalError("Something has gone horribly wrong.")
                }
            })
            task?.resume()
        })
    }
    
    static func asJSON(from data: Data) -> Promise<[JSONDictionary]> {
        return Promise<[JSONDictionary]>( work: { fulfill, reject in
            
            var json: JSONDictionary?
            do {
                json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONDictionary
            } catch {
                fatalError("Cannot parse this data!")
            }
            //TODO:
            // Drill down into data -> reults
            let data = json?["data"] as! JSONDictionary
            fulfill(data["results"] as! [JSONDictionary])
        })
    }
    
    static func asObjects(from json: [JSONDictionary]) -> Promise<[MarvelCharacter]> {
        return Promise<[MarvelCharacter]>( work: { fulfill, reject in
            
            var newObjects = [MarvelCharacter]()
            for characterJSON in json {
                if let newObject = MarvelCharacter(attributes: characterJSON) {
                    newObjects.append(newObject)
                }
            }
            fulfill(newObjects)
        })
    }
    
    static func fetch(completion: @escaping (Bool)-> Void){
        fetchRemote()
            .then({ data, httpResponse in
                return data
            })
            .then({ data in
                return asJSON(from: data)
            })
            .then({ json in
                return asObjects(from: json)
            })
            .then({ objects in
                
                let unsorted = objects
                self.characters = unsorted.sorted( by: { $0.name?.localizedCaseInsensitiveCompare($1.name!) == ComparisonResult.orderedAscending } )
                completion(true)
            })
            .catch({ error in
                print(error)
            })
        
        fetchRemote().then({ data in
            print("Have \(data.0.count) bytes of Data")
        })
        
    }
}
