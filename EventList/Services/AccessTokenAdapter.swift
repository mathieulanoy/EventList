//
//  AccessTokenAdapter.swift
//  EventList
//
//  Created by Mathieu LANOY on 14/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import Alamofire

class AccessTokenAdapter:RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
