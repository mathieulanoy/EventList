//
//  ELPlaceModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ELPlaceModel {
    let placeId:                        Int
    let userId:                         Int
    let title:                          String
    let description:                    String
    let locality:                       String
    let administrative_area_level_2:    String
    let administrative_area_level_1:    String
    let country:                        String
    let country_iso:                    String
    let postal_code:                    String
    let coordinates_latitude:           Double
    let coordinates_longitude:          Double
    let coordinates_zoom:               Int
    let coordinates_radius:             Int
    let timezone:                       String
    
    init(jsonObject:JSON) {
        placeId = jsonObject["id"].intValue
        userId = jsonObject["user_id"].intValue
        title = jsonObject["title"].stringValue
        description = jsonObject["description"].stringValue
        locality = jsonObject["locality"].stringValue
        administrative_area_level_2 = jsonObject["administrative_area_level_2"].stringValue
        administrative_area_level_1 = jsonObject["administrative_area_level_1"].stringValue
        country = jsonObject["country"].stringValue
        country_iso = jsonObject["country_iso"].stringValue
        postal_code = jsonObject["postal_code"].stringValue
        coordinates_latitude = jsonObject["coordinates", "latitude"].doubleValue
        coordinates_longitude = jsonObject["coordinates", "longitude"].doubleValue
        coordinates_zoom = jsonObject["coordinates", "zoom"].intValue
        coordinates_radius = jsonObject["coordinates", "radius"].intValue
        timezone = jsonObject["timezone"].stringValue
    }
}
