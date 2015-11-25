//
//  TraktClient.swift
//  MovieApp
//
//  Created by Fernando Ferreira on 25/11/15.
//  Copyright © 2015 Fernando Ferreira. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TraktClient {
    
    private let manager: Alamofire.Manager
    
    init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var headers = Alamofire.Manager.defaultHTTPHeaders
        headers["Accept-Encoding"] = "gzip"
        headers["Content-Type"] = "application/json"
        headers["trakt-api-version"] = "2"
        headers["trakt-api-key"] = Router.clientId
        configuration.HTTPAdditionalHeaders = headers
        
        manager = Manager(configuration: configuration)
    }
    
    func getMovies(completionHandler:  (([Movie]) -> ())){
        
        let router = Router.GetMovies
        manager.request(router).responseJSON { response in
            
            var movies = [Movie]()
            
            if let info = response.result.value {
                
                let json = JSON(info)
                
                print(json)
                movies = Movie.decodeArray(json)
                
            } else {
                
                
                print(response.result.error.debugDescription)
            }
            completionHandler(movies)
        }
    }
}

private enum Router: URLRequestConvertible {
    
    static let clientId = "395ee40b0f30abc5ee38ba3420922a0fa6a1edb15f9529f7d769e50015d8c864"
    static let baseURLString = "https://api-v2launch.trakt.tv"
    
    case GetMovies
    
    var URLRequest: NSMutableURLRequest {
        
        let (path, parameters, method): (String, [String : AnyObject]?, Alamofire.Method) = {
            switch self {
            case .GetMovies:
                
                let calendar = NSCalendar.currentCalendar()
                let day = calendar.component(.Day, fromDate: NSDate())
                let month = calendar.component(.Month, fromDate: NSDate())
                let year = calendar.component(.Year, fromDate: NSDate())
                let date = "\(year)-\(month)-\(day)"
                return ("calendars/all/shows", ["extended": "images", "start_date":date, "days": "1"],  .GET)
            }
        }()
        
        let url = NSURL(string: Router.baseURLString)!
        let urlRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
        urlRequest.HTTPMethod = method.rawValue
        
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(urlRequest, parameters: parameters).0
    }
}
