//
//  ELEventModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ELEventModel {

    let eventId:            Int
    let title:              String
    let min_seats:          Int
    let max_seats:          Int
    let type:               String
    let localized_type:     String
    let begins_at:          String
    let ends_at:            String
    let cover:              ELImageModel
    let user:               ELUserModel
    let place:              ELPlaceModel
    let food:               ELFoodModel
    let diets:              [ELFoodModel]
    let languages:          [ELLanguageModel]
    let price:              Int
    let currency:           ELCurrencyModel
    
    init(jsonObject:JSON) {
        eventId = jsonObject["id"].intValue
        title = jsonObject["title"].stringValue
        min_seats = jsonObject["min_seats"].intValue
        max_seats = jsonObject["max_seats"].intValue
        type = jsonObject["type"].stringValue
        localized_type = jsonObject["localized_type"].stringValue
        begins_at = jsonObject["begins_at"].stringValue
        ends_at = jsonObject["ends_at"].stringValue
        cover = ELImageModel(jsonObject: jsonObject["cover"])
        user = ELUserModel(jsonObject: jsonObject["user"])
        place = ELPlaceModel(jsonObject: jsonObject["place"])
        food = ELFoodModel(jsonObject: jsonObject["food"])
        diets = jsonObject["diets"].arrayValue.map{ELFoodModel(jsonObject:$0)}
        languages = jsonObject["languages"].arrayValue.map{ELLanguageModel(jsonObject:$0)}
        price = jsonObject["price"].intValue
        currency = ELCurrencyModel(jsonObject: jsonObject["currency"])
    }
}

// MARK: Webservice Usage
fileprivate enum EventEndpoint {
    static let all = "https://dl.dropboxusercontent.com/u/6656652/events.json"
}

extension ELEventModel {
    
    static let all = ELResource<(indexes:[String], values:[String: [ELEventModel]])>(url: URL(string:EventEndpoint.all)!, parseHandler: {json in
        guard let json = json else { return nil }
        let jsonObject = JSON(json)
        var events = jsonObject["events"].arrayValue
            .map{ELEventModel(jsonObject:$0)}
            .sorted {
                if $0.food.title.localizedCaseInsensitiveCompare($1.food.title) == .orderedSame {
                    return $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
                }
                return $0.food.title.localizedCaseInsensitiveCompare($1.food.title) == .orderedAscending
            }
            .groupedBy {$0.food.title}
        return (indexes:Array(events.keys).sorted(by: <), values:events)
    })
}
