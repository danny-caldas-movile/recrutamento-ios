//
//  Movie.swift
//  MovieApp
//
//  Created by Fernando Ferreira on 25/11/15.
//  Copyright © 2015 Fernando Ferreira. All rights reserved.
//

import SwiftyJSON

struct Movie {
 
    let thumbnail: NSURL?
    let name: String?
}

extension Movie: Decodable {
    
    static func decode(json: JSON) -> Movie? {
        
        let thumbnail = json["movie"]["images"]["poster"]["medium"].URL
        let name = json["movie"]["title"].string
        
        return Movie(thumbnail: thumbnail, name:name);
    }
}
