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
    
    func getMovies(completionHandler: () -> ()){
        
        let router = Router.GetMovies
        manager.request(router).responseJSON { response in
            
            if let info = response.result.value {
                
                let json = JSON(info)
                
                print(json)
                
            } else {
                print(response.result.error.debugDescription)
            }

            
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
                
                let myParameters = ["start_date": "2015-11-01", "days": "7"];
                
                return ("calendars/all/movies", myParameters,  .GET)
            }
        }()
        
        let url = NSURL(string: Router.baseURLString)!
        let urlRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
        urlRequest.HTTPMethod = method.rawValue
        
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(urlRequest, parameters: parameters).0
    }
    
}
