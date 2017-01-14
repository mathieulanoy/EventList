//
//  ELLoadingProtocol.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

protocol LoadingProtocol {
    associatedtype ResourceType
    func configure(_ value: ResourceType)
}
