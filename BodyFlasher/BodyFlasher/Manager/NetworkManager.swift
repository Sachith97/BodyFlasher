//
//  NetworkManager.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-16.
//

import Foundation

class NetworkManager {
    
    let baseURL = ""
    
    static let shared = NetworkManager()
    
    init() {}
    
    func login(username: String, password: String) -> Response {
        var responseObj = Response()
        let url = URL(string: baseURL + "")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                var apiResponse = try JSONDecoder().decode(Response.self, from: data)
                responseObj = apiResponse
            } catch {
                responseObj = Response(isOk: false, responseCode: 500, responseMessage: "Error occured")
            }
        }
        dataTask.resume()
        return responseObj
    }
    
    func sendWorkoutPlanRequest(planRequest: WorkoutPlanRequest) -> Bool {
        return true
    }
}
