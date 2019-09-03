//
//  SetLocationResponse.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

struct UpdateLocationResponse: Codable {
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updatedAt"
    }
}

struct SetLocationResponse: Codable {
    let createdAt: String
    let objectId: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case objectId = "objectId"
    }
}
