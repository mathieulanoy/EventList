//
//  ELResult.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

public enum Result<A> {
    case success(A)
    case error(Error?)
}

extension Result {
    public init(_ value: A?, or error: Error?){
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
    
    public var value: A? {
        guard case .success(let v) = self else { return nil }
        return v
    }
    
    public var error: Error? {
        guard case .error(let e) = self else { return nil }
        return e
    }
}
