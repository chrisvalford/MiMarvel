//
//  MarvelReturnedComics.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct MarvelReturnedComics {
     var code: Int?
     var status: String? // OK
     var copyright: String?
     var attributionText: String?
     var attributionHTML: String?
     var etag: String?
    
    //JSON group "data": {
    
    var comicResults: MarvelComicResults?
    
    init(){}
    
    init?(json: JSONDictionary) {
        // Populate the MarvelReturnedComics, header values
        self.code = json["code"] as? Int
        self.status = json["status"] as? String
        self.copyright = json["copyright"] as? String
        self.attributionText = json["attributionText"] as? String
        self.attributionHTML = json["attributionHTML"] as? String
        self.etag = json["etag"] as? String
        
        if let data = MarvelComicResults(json: json["data"] as! JSONDictionary) {
            self.comicResults = data
        }
        else {
            return nil
        }
    }
}

extension  MarvelReturnedComics {
    
 static func fetch(completion: @escaping (MarvelReturnedComics)-> Void){
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
                completion(objects)
            })
            .catch({ error in
                print(error)
            })
        
        fetchRemote().then({ data in
            print("Have \(data.0.count) bytes of Data")
        })
        
    }
    
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
            
            let urlPath = "https://gateway.marvel.com:443/v1/public/comics?format=graphic%20novel&formatType=collection&limit=100&apikey=\(apiKey)&ts=\(ts)&hash=\(ServiceUtils.md5(string: ts + secret + apiKey))"

            //let urlPath = "http://gateway.marvel.com:80/v1/public/comics?format=comic&formatType=comic&noVariants=true&orderBy=title&apikey=\(apiKey)&ts=\(ts)&hash=\(MMServiceUtils.md5(string: ts + secret + apiKey))"
            
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
    
    static func asJSON(from data: Data) -> Promise<JSONDictionary> {
        return Promise<JSONDictionary>( work: { fulfill, reject in
            
            var json: JSONDictionary?
            do {
                json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONDictionary
            } catch {
                fatalError("Cannot parse this data!")
            }
            fulfill(json!)
        })
    }
    
    static func asObjects(from json: JSONDictionary) -> Promise<MarvelReturnedComics> {
        return Promise<MarvelReturnedComics>( work: { fulfill, reject in
            let results = MarvelReturnedComics(json: json)
            fulfill(results!)
        })
    }
    
}
