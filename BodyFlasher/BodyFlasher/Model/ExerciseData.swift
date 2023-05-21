//
//  ExerciseData.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-21.
//

import Foundation

struct ExerciseData {
    
    let title: String
    let image: String
    let info: String
    var allocatedSeconds: Int
    let goal: String?
    
    init(title: String, image: String, info: String, allocatedSeconds: Int, goal: String) {
        self.title = title
        self.image = image
        self.info = info
        self.allocatedSeconds = allocatedSeconds
        self.goal = goal
    }
    
    init(title: String, image: String, info: String, allocatedSeconds: Int) {
        self.title = title
        self.image = image
        self.info = info
        self.allocatedSeconds = allocatedSeconds
        self.goal = nil
    }
}
