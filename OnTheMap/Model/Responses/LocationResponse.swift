//
//  LocationResponse.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

struct LocationResponse: Codable {
    let results: [Location]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
