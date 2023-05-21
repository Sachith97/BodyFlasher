//
//  NetworkManager.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-16.
//

import Foundation
import Combine

enum NetworkError: Error {
    case APIError
    case DecodingError
}

class NetworkManager {
    
    let baseURL = "http://108.161.133.103:8080/workout-service/api/v1"
    
    static let shared = NetworkManager()
    
    init() {}
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        let requestBody: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        getAPIResponse(body: requestBody, requestURL: baseURL + "/auth/login", httpMethod: "POST", headers: headers, model: LoginResponse.self) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let response):
                // Handle the API response
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            case .failure(let error):
                // Handle the API error
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func sendWorkoutPlanRequest(planRequest: WorkoutPlanRequest, jwt: String, completion: @escaping (Result<Response, Error>) -> Void) {
        
        let headers = [
            "Authorization": "Bearer " + jwt,
            "Content-Type": "application/json"
        ]

        let requestBody: [String: Any] = [
            "birthdayTimestamp": planRequest.birthday?.timeIntervalSince1970,
            "gender": planRequest.gender,
            "height": planRequest.height,
            "weight": planRequest.weight,
            "goal": planRequest.goal
        ]
        
        getAPIResponse(body: requestBody, requestURL: baseURL + "/workouts/request", httpMethod: "POST", headers: headers, model: Response.self) { (result: Result<Response, Error>) in
            switch result {
            case .success(let response):
                // Handle the API response
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            case .failure(let error):
                // Handle the API error
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func getAPIResponse<T: Decodable>(body: [String: Any]?, requestURL: String, httpMethod: String, headers: [String: String], model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        // initialize request with url
        guard let url = URL(string: requestURL) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        var request = URLRequest(url: url)
        
        // apply http method
        request.httpMethod = httpMethod
        
        // apply headers
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // apply request body
        if let requestBody = body, !(body?.isEmpty ?? false) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NSError(domain: "Bad server response", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // Process the data and decode it into the desired type T
            // Assuming you are using JSON data and Codable for decoding
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
