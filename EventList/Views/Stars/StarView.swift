//
//  ELStarView.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class StarView: UIView {

    var fillColor:UIColor = .clear
    var strokeColor:UIColor = UIColor(red: 188.0/255.0, green: 188.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    
    func pointFrom(_ angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
    }
    
    func starPathInRect(_ rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let starExtrusion:CGFloat = rect.width / 4.0
        
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        
        let pointsOnStar = 5 // + arc4random() % 10
        
        var angle:CGFloat = -CGFloat(M_PI / 2.0)
        let angleIncrement = CGFloat(M_PI * 2.0 / Double(pointsOnStar))
        let radius = rect.width / 2.0
        
        var firstPoint = true
        
        for _ in 1...pointsOnStar {
            
            let point = pointFrom(angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
            
            if firstPoint {
                firstPoint = false
                path.move(to: point)
            }
            
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            
            angle += angleIncrement
        }
        
        path.close()
        
        
        return path
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        fillColor.setFill()
        let path = self.starPathInRect(rect)
        
        path.fill()
        
        strokeColor.setStroke()
        path.lineWidth = 0.5
        path.stroke()
    }
}
