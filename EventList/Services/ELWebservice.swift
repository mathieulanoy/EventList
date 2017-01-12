//
//  ELWebservice.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import Alamofire

class ELWebservice {
    
    func load<A>(resource: ELResource<A>, completion: @escaping (ELResult<A>) -> ()) {
        Alamofire.request(resource.url)
        .validate()
        .responseJSON{ response in
            switch response.result {
            case .success:
                let parsedObject = resource.parse(response.result.value)
                let result = ELResult(parsedObject, or: nil)
                DispatchQueue.main.async {
                    completion(result)
                }
            case .failure(let error):
                let result:ELResult<A> = ELResult(nil, or: error)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
    
}
