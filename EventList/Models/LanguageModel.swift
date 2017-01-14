//
//  ELLanguageModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

struct LanguageModel {

    let languageId: Int
    let translated: Bool
    let activated:  Bool
    let title:      String
    let i_speak:    String
    let alpha2:     String
    let alpha3_b:   String
    let alpha3_t:   String
    let locale:     String
    
    init(jsonObject:JSON) {
        languageId = jsonObject["id"].intValue
        translated = jsonObject["translated"].boolValue
        activated = jsonObject["activated"].boolValue
        title = jsonObject["title"].stringValue
        i_speak = jsonObject["i_speak"].stringValue
        alpha2 = jsonObject["alpha2"].stringValue
        alpha3_b = jsonObject["alpha3-b"].stringValue
        alpha3_t = jsonObject["alpha3-t"].stringValue
        locale = jsonObject["locale"].stringValue
    }
    
}
