//
//  ELUserModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ELUserModel {
    let userId:             Int
    let civility:           String
    let firstname:          String
    let description_title:  String
    let description:        String
    let age:                String
    let user_rating_score:  Float
    let user_rating_count:  Int
    let avatar:             ELImageModel
    
    init(jsonObject:JSON) {
        userId = jsonObject["id"].intValue
        civility = jsonObject["civility"].stringValue
        firstname = jsonObject["firstname"].stringValue
        description_title = jsonObject["description_title"].stringValue
        description = jsonObject["description"].stringValue
        age = jsonObject["age"].stringValue
        user_rating_score = jsonObject["rating", "score"].floatValue
        user_rating_count = jsonObject["rating", "count"].intValue
        avatar = ELImageModel(jsonObject: jsonObject["avatar"])
    }
}
