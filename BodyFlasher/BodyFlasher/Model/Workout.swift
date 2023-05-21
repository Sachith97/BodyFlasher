//
//  Workout.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-23.
//

import Foundation

struct Workout: Decodable, Sequence {
    
    var goal: String
    var imageName: String
    var experience: String?
    var workoutList: [WorkoutDetail]?
    
    func makeIterator() -> IndexingIterator<[WorkoutDetail]> {
        return workoutList!.makeIterator()
    }
}
