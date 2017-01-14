//
//  API.swift
//  EventList
//
//  Created by Mathieu LANOY on 14/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import Alamofire

class API {
    static let shared = API()
    
    let sessionManager: SessionManager
    
    var accessToken: String? {
        didSet {
            if let accessToken = accessToken {
                sessionManager.adapter = AccessTokenAdapter(accessToken: accessToken)
            }
        }
    }
    
    init() {
        sessionManager = SessionManager()
    }

}
