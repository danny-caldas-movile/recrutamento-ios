//
//  Decodable.swift
//  MovieApp
//
//  Created by Fernando Ferreira on 25/11/15.
//  Copyright © 2015 Fernando Ferreira. All rights reserved.
//

import SwiftyJSON

protocol Decodable {
    
    static func decode(json: JSON) -> Self?
}

extension Decodable {
    
    static func decodeArray(json: JSON) -> [Self] {
        guard let arrayJSON = json.array else {
            return []
        }
        
        return arrayJSON.flatMap{ Self.decode($0) }
    }
}