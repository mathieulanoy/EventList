//
//  String+size.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

extension String {
    
    func textSize(withFont font:UIFont) -> CGSize{
        return self.textSize(withFont: font, maximumWidth: CGFloat.greatestFiniteMagnitude)
    }
    
    func textSize(withFont font:UIFont, maximumWidth width: CGFloat) -> CGSize{
        let attributedText = NSAttributedString(string: self, attributes: [NSFontAttributeName:font])
        let rect = attributedText.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                               options: .usesLineFragmentOrigin,
                                               context: nil)
        let size = rect.size
        return CGSize(width:ceil(Double(size.width)), height:ceil(Double(size.height)))
    }
}
