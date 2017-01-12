//
//  NSLayoutAnchor+autoLayout.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

extension NSLayoutAnchor {
    public func constrainEqual(anchor: NSLayoutAnchor, constant: CGFloat = 0) {
        let constrain = constraint(equalTo: anchor, constant: constant)
        constrain.isActive = true
    }
}
