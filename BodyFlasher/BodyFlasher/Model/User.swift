//
//  User.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-19.
//

import Foundation

struct User: Decodable {
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var profession: String?
    var age: Int?
    var weight: Int?
    var height: Int?
    var bmiValue: Double?
    var username : String?
}
