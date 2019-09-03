//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

struct account: Codable {
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered
        case key = "key"
    }
}

struct LoginResponse: Codable {
    let account: account
    let session: LogoutResponse
    
    enum CodingKeys: String, CodingKey {
        case account
        case session
    }
}
