//
//  ELCollectionViewCell.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    class var identifier: String {
        let className = String(describing: self)
        
        return className
    }
    
    override func awakeFromNib() {
        setupStyle()
    }
    
    func setupStyle(){
        
    }
}
