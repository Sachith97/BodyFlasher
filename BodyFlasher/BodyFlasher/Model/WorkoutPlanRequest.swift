//
//  WorkoutPlanRequest.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-16.
//

import Foundation

struct WorkoutPlanRequest: Codable {
    
    var gender: String?
    var birthday: Date?
    var height: Int?
    var weight: Int?
    var goal: String?
}
