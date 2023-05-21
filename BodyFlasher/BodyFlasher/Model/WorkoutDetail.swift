//
//  WorkoutDetail.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-23.
//

import Foundation

struct WorkoutDetail: Decodable {
    
    var id: Int
    var workoutName: String
    var instructions: String
    var day: Int?
    var allocatedSeconds: Int
    var completedSeconds: Int?
    var imageName: String
    var resourceURL: String?
}
