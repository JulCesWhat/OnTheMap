//
//  LoginErrorResponse.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 9/5/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let status: Int
    let error: String
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
