//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation


struct UserData: Codable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}


struct LoginRequest: Codable {
    
    let udacity: UserData
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
}
