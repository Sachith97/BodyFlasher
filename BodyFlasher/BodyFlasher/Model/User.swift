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
    var age: Int?
    var weight: Int?
    var height: Int?
    var username : String?
    
    init () { }
    
    init (firstName: String? = nil, lastName: String? = nil, email: String? = nil, age: Int? = nil, weight: Int?, height: Int?, username: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.weight = weight
        self.height = height
        self.username = username
    }
}
