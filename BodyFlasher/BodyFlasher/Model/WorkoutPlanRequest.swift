//
//  WorkoutPlanRequest.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-16.
//

import Foundation

struct WorkoutPlanRequest: Codable {
    
    var gender : String?
    var birthday : Date?
    var height : Int?
    var weight : Int?
    var goal : String?
    
    init (gender: String? = nil, birthday: Date? = nil, height: Int? = nil, weight: Int? = nil, goal: String? = nil) {
        self.gender = gender
        self.birthday = birthday
        self.height = height
        self.weight = weight
        self.goal = goal
    }
}
