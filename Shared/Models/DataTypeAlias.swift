//
//  DataTypeAlias.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

typealias paramType = (key: String, value: AnyObject, operator: String)
typealias FetchCompletion = (_ data: Data?, _ message: String?) -> Void
typealias ComicList = [CollectionItem]
typealias StoryList = [CollectionItem]
typealias EventList = [CollectionItem]
typealias SeriesList = [CollectionItem]

enum DataManagerError: Error {
    case internalError
    case invalidFormat
    case missingData(dataNamed: String)
    case serverError
    case networkError
    case notFound
}
