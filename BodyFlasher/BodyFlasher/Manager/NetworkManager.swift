//
//  NetworkManager.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-16.
//

import Foundation

class NetworkManager {
    
    let baseURL = "http://13.54.141.32/workout-service/api/v1"
    
    static let shared = NetworkManager()
    
    init() {}
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        // API endpoint URL
        guard let url = URL(string: baseURL + "/auth/login") else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            }
            return
        }

        // Prepare the request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Set the request body
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }

        // Set the request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create a URLSession and make the request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            if let data = data {
                do {
                    // Parse the response data into a response entity
                    let decoder = JSONDecoder()
                    let responseEntity = try decoder.decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(responseEntity))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }

        // Start the request
        task.resume()
    }
    
    func sendWorkoutPlanRequest(planRequest: WorkoutPlanRequest, jwt: String, completion: @escaping (Result<Response, Error>) -> Void) {
        // API endpoint URL
        guard let url = URL(string: baseURL + "/workouts/request") else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            }
            return
        }

        // Prepare the request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Set the request body
        let parameters: [String: Any] = [
            "birthdayTimestamp": planRequest.birthday?.timeIntervalSince1970,
            "gender": planRequest.gender,
            "height": planRequest.height,
            "weight": planRequest.weight,
            "goal": planRequest.goal
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }

        // Set the request headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + jwt, forHTTPHeaderField: "Authorization")

        // Create a URLSession and make the request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            if let data = data {
                do {
                    // Parse the response data into a response entity
                    let decoder = JSONDecoder()
                    let responseEntity = try decoder.decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(responseEntity))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }

        // Start the request
        task.resume()
    }
}
