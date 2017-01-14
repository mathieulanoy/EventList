//
//  ELWebservice.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import Alamofire

class Webservice {
    
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> ()) {
        API.shared.sessionManager.request(resource.url)
        .validate()
        .responseJSON{ response in
            switch response.result {
            case .success:
                let parsedObject = resource.parse(response.result.value)
                let result = Result(parsedObject, or: nil)
                DispatchQueue.main.async {
                    completion(result)
                }
            case .failure(let error):
                let result:Result<A> = Result(nil, or: error)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
    
}
