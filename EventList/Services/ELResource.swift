//
//  ELResource.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

struct ELResource<A> {
    let url: URL
    let parse: (Any?) -> A?
}

extension ELResource {
    init(url: URL, parseHandler: @escaping (Any?) -> A?) {
        self.url = url
        self.parse = parseHandler
    }
}
