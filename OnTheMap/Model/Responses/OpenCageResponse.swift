//
//  OpenCageResponse.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 9/1/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

// MARK: - OpenCageResponse
struct OpenCageResponse: Codable {
    let documentation: String
    let licenses: [License]
    let rate: Rate
    let results: [Result]
    let status: Status
    let stayInformed: StayInformed
    let thanks: String
    let timestamp: Timestamp
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case documentation, licenses, rate, results, status
        case stayInformed = "stay_informed"
        case thanks, timestamp
        case totalResults = "total_results"
    }
}

// MARK: - License
struct License: Codable {
    let name: String
    let url: String
}

// MARK: - Rate
struct Rate: Codable {
    let limit, remaining, reset: Int
}

// MARK: - Result
struct Result: Codable {
    let bounds: Bounds
    let components: Components
    let confidence: Int
    let formatted: String
    let geometry: Geometry
}

// MARK: - Bounds
struct Bounds: Codable {
    let northeast, southwest: Geometry
}

// MARK: - Geometry
struct Geometry: Codable {
    let lat, lng: Double
}

// MARK: - Components
struct Components: Codable {
    let iso31661_Alpha2, iso31661_Alpha3, type, city: String?
    let cityDistrict, continent, country, countryCode: String?
    let politicalUnion, state, stateCode, suburb: String?
    
    enum CodingKeys: String, CodingKey {
        case iso31661_Alpha2 = "ISO_3166-1_alpha-2"
        case iso31661_Alpha3 = "ISO_3166-1_alpha-3"
        case type = "_type"
        case city
        case cityDistrict = "city_district"
        case continent, country
        case countryCode = "country_code"
        case politicalUnion = "political_union"
        case state
        case stateCode = "state_code"
        case suburb
    }
}

// MARK: - Status
struct Status: Codable {
    let code: Int
    let message: String
}

// MARK: - StayInformed
struct StayInformed: Codable {
    let blog, twitter: String
}

// MARK: - Timestamp
struct Timestamp: Codable {
    let createdHTTP: String
    let createdUnix: Int
    
    enum CodingKeys: String, CodingKey {
        case createdHTTP = "created_http"
        case createdUnix = "created_unix"
    }
}
