//
//  Location.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

//struct BaseLocation {
//    let uniqueKey: String
//    let firstName: String
//    let lastName: String
//    let mapString: String
//    let mediaURL: String
//    let latitude: Double
//    let longitude: Double
//
//    enum CodingKeys: String, CodingKey {
//        case uniqueKey = "uniqueKey"
//        case firstName = "firstName"
//        case lastName = "lastName"
//        case mapString = "mapString"
//        case mediaURL = "mediaURL"
//        case latitude = "latitude"
//        case longitude = "longitude"
//    }
//}

struct Location: Codable, Equatable {
    let latitude, longitude: Double
    let firstName, lastName, mapString, mediaURL, uniqueKey: String
    let createdAt, updatedAt, objectId: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case firstName = "firstName"
        case lastName = "lastName"
        case latitude = "latitude"
        case longitude = "longitude"
        case mapString = "mapString"
        case mediaURL = "mediaURL"
        case objectId = "objectId"
        case uniqueKey = "uniqueKey"
        case updatedAt = "updatedAt"
    }
}
