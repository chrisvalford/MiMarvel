//
//  ImagePath.swift
//  MiMarvel
//
//  Created by Christopher Alford on 26.07.17.
//  Copyright © 2017 AnApp4That. All rights reserved.
//

import Foundation

struct ImagePath {
    var path: String?
    var ext: String?
    
    init?(json: JSONDictionary) {
        guard let path = json["path"] as? String, let ext = json["extension"] as? String else {
            return nil
        }
        self.path = path
        self.ext = ext
    }
    
    init?(path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
    
    func url() -> URL? {
        guard let _ = self.path, let _ = self.ext else {
            return nil
        }
        return URL(string: path! + "." + ext!)
    }
}
