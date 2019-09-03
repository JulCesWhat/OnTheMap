//
//  LogoutRequest.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

struct LogoutRequest: Codable {
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
    }
}
