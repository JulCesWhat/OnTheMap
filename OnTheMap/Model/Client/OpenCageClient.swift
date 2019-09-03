//
//  OpenCageClient.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 9/1/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

class OpenCageClient {
    
    static let apiKey = "08303b3aeb054ac2bb623e7b7544804b"
    
    enum Endpoints {
        static let base = "https://api.opencagedata.com/geocode/v1/json"
        static let apiKeyParam = "&key=\(OpenCageClient.apiKey)"
        static let extraParam = "&language=en&pretty=1&no_annotations=1&limit=1"
        
        case getCoordinates(String)
        
        var stringValue: String {
            switch self {
            case .getCoordinates(let query):
                return Endpoints.base + "?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" )" + Endpoints.apiKeyParam + Endpoints.extraParam
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
//                print(decoder)
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
//                print(error)
//                do {
//                    let errorResponse = try decoder.decode(TMDBResponse.self, from: data) as Error
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
//                }
            }
        }
        task.resume()
        
        return task
    }
    
    class func search(query: String, completion: @escaping ([Result], Error?) -> Void) -> Void {
//        print(Endpoints.getCoordinates(query).url)
        let _ = taskForGETRequest(url: Endpoints.getCoordinates(query).url, responseType: OpenCageResponse.self) { response, error in
            if let response = response {
//                print(response)
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
}
