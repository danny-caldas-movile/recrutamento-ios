//
//  Movie.swift
//  MovieApp
//
//  Created by Fernando Ferreira on 25/11/15.
//  Copyright © 2015 Fernando Ferreira. All rights reserved.
//

import SwiftyJSON

struct Show {
    let thumbnail: NSURL?
    let title: String!
}

extension Show: Decodable {
    
    static func decode(json: JSON) -> Show? {
        
        let thumbnail = json["show"]["images"]["poster"]["medium"].URL
        guard let title = json["show"]["title"].string else {
            return nil
        }
        
        return Show(thumbnail: thumbnail, title:title);
    }
}
