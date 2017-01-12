//
//  ELCurrencyModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ELCurrencyModel {

    let currencyId:     Int
    let title:          String
    let iso_3:          String
    let symbol:         String
    
    init(jsonObject:JSON) {
        currencyId = jsonObject["id"].intValue
        title = jsonObject["title"].stringValue
        iso_3 = jsonObject["iso_3"].stringValue
        symbol = jsonObject["symbol"].stringValue
    }
    
}
