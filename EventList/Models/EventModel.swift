//
//  ELEventModel.swift
//  EventList
//
//  Created by Mathieu LANOY on 11/01/2017.
//  Copyright © 2017 Mathieu LANOY. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventModel {

    let eventId:            Int
    let title:              String
    let min_seats:          Int
    let max_seats:          Int
    let type:               String
    let localized_type:     String
    let begins_at:          String
    let ends_at:            String
    let cover:              ImageModel
    let user:               UserModel
    let place:              PlaceModel
    let food:               FoodModel
    let diets:              [FoodModel]
    let languages:          [LanguageModel]
    let price:              Int
    let currency:           CurrencyModel
    
    init(jsonObject:JSON) {
        eventId = jsonObject["id"].intValue
        title = jsonObject["title"].stringValue
        min_seats = jsonObject["min_seats"].intValue
        max_seats = jsonObject["max_seats"].intValue
        type = jsonObject["type"].stringValue
        localized_type = jsonObject["localized_type"].stringValue
        begins_at = jsonObject["begins_at"].stringValue
        ends_at = jsonObject["ends_at"].stringValue
        cover = ImageModel(jsonObject: jsonObject["cover"])
        user = UserModel(jsonObject: jsonObject["user"])
        place = PlaceModel(jsonObject: jsonObject["place"])
        food = FoodModel(jsonObject: jsonObject["food"])
        diets = jsonObject["diets"].arrayValue.map{FoodModel(jsonObject:$0)}
        languages = jsonObject["languages"].arrayValue.map{LanguageModel(jsonObject:$0)}
        price = jsonObject["price"].intValue
        currency = CurrencyModel(jsonObject: jsonObject["currency"])
    }
}

// MARK: Webservice Usage
extension EventModel {
    
    static let all = Resource<(indexes:[String], values:[String: [EventModel]])>(url: Router.events(eventsId: "6656652"), parseHandler: {json in
        guard let json = json else { return nil }
        let jsonObject = JSON(json)
        var events = jsonObject["events"].arrayValue
            .map{EventModel(jsonObject:$0)}
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
