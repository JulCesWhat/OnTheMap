//
//  LocationClient.swift
//  OnTheMap
//
//  Created by Julio Cesar Whatley on 8/31/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation

class LocationClient {
    
    struct Auth {
        static var objectId = ""
        static var userId = ""
        static var user: UserDataResponse?
    }
    
    static var studentLocation: [Location] = []
    static var userLocation: Location?
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getStudentLocations
        case setStudentLocation
        case updateStudentLocation
        case login
        case logout
        case getUserData
        
        var stringValue: String {
            switch self {
            case .getStudentLocations:
                return Endpoints.base + "/StudentLocation?limit=5"
            case .setStudentLocation:
                return Endpoints.base + "/StudentLocation"
            case .updateStudentLocation:
                return Endpoints.base + "/StudentLocation/" + Auth.objectId
            case .login,
                .logout:
                return Endpoints.base + "/session"
            case .getUserData:
                return Endpoints.base + "/users/" + Auth.userId
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, authMethod: Bool = false, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                if authMethod {
                    let newData = data.subdata(in: 5..<data.count)
//                    print(String(data: newData, encoding: .utf8)!)
                    let responseObject = try decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
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
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, authMethod: Bool = false, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                if authMethod {
                    let newData = data.subdata(in: 5..<data.count)
                    let responseObject = try decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
                
            } catch {
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
    }
    
    class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
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
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginRequest(udacity: UserData(username: username, password: password))
        taskForPOSTRequest(url: Endpoints.login.url, authMethod: true, responseType: LoginResponse.self, body: body) { response, error in
            if let response = response {
                Auth.userId = response.account.key
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func getUserData(completion: @escaping (Bool, Error?) -> Void) -> Void {
        let _ = taskForGETRequest(url: Endpoints.getUserData.url, authMethod: true, responseType: UserDataResponse.self) { response, error in
            if let response = response {
                Auth.user = response
                print(response);
                print("------------------")
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
//        return task
    }
    
    class func getUserLocations(completion: @escaping ([Location], Error?) -> Void) -> Void {
        let _ = taskForGETRequest(url: Endpoints.getStudentLocations.url, responseType: LocationResponse.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
//        return task
    }
    
    class func setLocation(body: Location, completion: @escaping (Bool, Error?) -> Void) {
        taskForPOSTRequest(url: Endpoints.setStudentLocation.url, responseType: SetLocationResponse.self, body: body) { response, error in
            if let _ = response {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func updateLocation(body: Location, completion: @escaping (Bool, Error?) -> Void) {
        taskForPUTRequest(url: Endpoints.login.url, responseType: UpdateLocationResponse.self, body: body) { response, error in
            if let _ = response {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
}
