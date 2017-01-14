//
//  ELResource.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import Alamofire

struct Resource<A> {
    let url: URLRequestConvertible
    let parse: (Any?) -> A?
}

extension Resource {
    init(url: URLRequestConvertible, parseHandler: @escaping (Any?) -> A?) {
        self.url = url
        self.parse = parseHandler
    }
}
