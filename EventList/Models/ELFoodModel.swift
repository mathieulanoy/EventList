//
//  ELFoodModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ELFoodModel {
    let foodId:         Int
    let title:          String
    let description:    String
    
    init(jsonObject:JSON) {
        foodId = jsonObject["id"].intValue
        title = jsonObject["title"].stringValue
        description = jsonObject["description"].stringValue
    }
}
