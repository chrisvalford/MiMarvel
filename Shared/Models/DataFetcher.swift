//
//  DataFetcher.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct DataFetcher {
    
    enum FetchError: Error {
        case incorrectResponse              // not HTTPURLResponse
        case jsonParsingFailed              // Could not create collection from data
        case objectInitializationFailed     // Could not create object from dictionary
        case non200ResponseCode(code: Int)  // Server returned non-200 response code
        case unknownError(error: Error)     // Wrap other errors that might occur
    }
    
    enum Result<T: DictionaryInitializable> {
        case success(object: T)
        case failure(error: FetchError)
    }
    
    private static func fetchRemote(request: URLRequest) -> Promise<(Data, HTTPURLResponse)> {
        
        return Promise<(Data, HTTPURLResponse)>() { fulfill, reject in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    reject(error)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        fulfill((data, response))
                    } else {
                        reject(FetchError.non200ResponseCode(code: response.statusCode))
                    }
                } else {
                    reject(FetchError.incorrectResponse)
                }
            }
            
            task.resume()
        }
    }
    
    private static func asJSON(from data: Data) -> Promise<JSONDictionary> {
        return Promise<JSONDictionary>() { fulfill, reject in
            let json: JSONDictionary?
            do {
                json = try JSONSerialization.jsonObject(with: data) as? JSONDictionary
            } catch {
                json = nil
            }
            
            if let json = json {
                fulfill(json)
            } else {
                reject(FetchError.jsonParsingFailed)
            }
        }
    }
    
    private static func asObject<T: DictionaryInitializable>(dictionary: JSONDictionary) -> Promise<T> {
        return Promise<T>() { fulfill, reject in
            if let object = T(dictionary: dictionary) {
                fulfill(object)
            } else {
                reject(FetchError.objectInitializationFailed)
            }
        }
    }
    
    static func fetch<T>(request: URLRequest, completion: @escaping ((Result<T>) -> Void)) {
        fetchRemote(request: request)
            .then { data, _ in
                return asJSON(from: data)
            }
            .then { dictionary in
                return asObject(dictionary: dictionary)
            }
            .then { object in
                completion(.success(object: object))
            }
            .catch { error in
                if let error = error as? FetchError {
                    completion(.failure(error: error))
                } else {
                    completion(.failure(error: .unknownError(error: error)))
                }
        }
        
    }
    
}
