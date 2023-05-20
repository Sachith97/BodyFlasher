//
//  LoginResponseDetail.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-20.
//

import Foundation

struct LoginResponseDetail: Decodable {
    
    var jwt: String?
    var user: User?
    
    init () { }
    
    init (jwt: String, user: User) {
        self.jwt = jwt
        self.user = user
    }
}
