//
//  Rooter.swift
//  EventList
//
//  Created by Mathieu LANOY on 14/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://dl.dropboxusercontent.com/u/"
    
    case events(eventsId: String)
    case addEvent(parameters: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .events:
            return .get
        case .addEvent:
            return .post
        }
    }

    var path: String {
        switch self {
        case .events(let eventsId):
            return "/\(eventsId)/events.json"
        case .addEvent:
            return "/event.json"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .addEvent(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        return urlRequest
    }

}
