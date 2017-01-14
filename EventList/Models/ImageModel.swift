//
//  ELEventCoverModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ImageModel {
    let imageId:            Int
    let accountId:          Int
    let path:               String
    let uploadcareId:       String
    let show:               Bool
    let attachableId:       Int
    let attachableType:     String
    let order:              Int
    
    init(jsonObject:JSON) {
        imageId = jsonObject["id"].intValue
        accountId = jsonObject["account_id"].intValue
        path = jsonObject["path"].stringValue
        uploadcareId = jsonObject["uploadcare_id"].stringValue
        show = jsonObject["show"].boolValue
        attachableId = jsonObject["attachable_id"].intValue
        attachableType = jsonObject["attachable_type"].stringValue
        order = jsonObject["order"].intValue
    }
}
