//
//  UIView+autoLayout.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

extension UIView {
    public func constrainEqual(attribute: NSLayoutAttribute, to: AnyObject, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        constrainEqual(attribute:attribute, to: to, toAttribute: attribute, multiplier: multiplier, constant: constant)
    }
    
    public func constrainEqual(attribute: NSLayoutAttribute, to: AnyObject, toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
            ]
        )
    }
    
    public func constrainEdges(toMarginOf view: UIView) {
        constrainEqual(attribute: .top, to: view, toAttribute: .top)
        constrainEqual(attribute: .leading, to: view, toAttribute: .leading)
        constrainEqual(attribute: .trailing, to: view, toAttribute: .trailing)
        constrainEqual(attribute: .bottom, to: view, toAttribute: .bottom)
    }
    
    public func center(inView view: UIView) {
        centerXAnchor.constrainEqual(anchor: view.centerXAnchor)
        centerYAnchor.constrainEqual(anchor: view.centerYAnchor)
    }
}
